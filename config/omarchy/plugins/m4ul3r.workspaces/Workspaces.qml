import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "m4ul3r.workspaces"

  // shell.json settings: { "showIcons": false } hides the per-window app
  // icons and falls back to plain numbers; tooltips keep working either way.
  readonly property bool showIcons: setting("showIcons", true) !== false
  readonly property int maxTitleLength: Number(setting("maxTitleLength", 60))
  readonly property int iconSize: Math.max(12, Math.round(barSize * 0.55))

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }

    return null
  }

  function workspaceIds() {
    var ids = [1, 2, 3, 4, 5]
    var values = Hyprland.workspaces.values

    for (var i = 0; i < values.length; i++) {
      var id = values[i].id
      if (id > 0 && id <= 10 && ids.indexOf(id) === -1) ids.push(id)
    }

    ids.sort(function(left, right) { return left - right })
    return ids
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  // The wayland handle can lag the Hyprland object by a frame, and IPC data
  // can outlive the wayland handle on close — try both before giving up.
  function windowAppId(toplevel) {
    if (!toplevel) return ""
    if (toplevel.wayland && toplevel.wayland.appId) return String(toplevel.wayland.appId)
    var ipc = toplevel.lastIpcObject
    if (ipc && ipc["class"]) return String(ipc["class"])
    return ""
  }

  function windowTitle(toplevel) {
    if (!toplevel) return ""
    if (toplevel.title) return String(toplevel.title)
    if (toplevel.wayland && toplevel.wayland.title) return String(toplevel.wayland.title)
    var ipc = toplevel.lastIpcObject
    if (ipc && ipc.title) return String(ipc.title)
    return ""
  }

  function iconSourceFor(appId) {
    var id = String(appId || "")
    if (id.length === 0) return ""
    var entry = null
    if (typeof DesktopEntries.heuristicLookup === "function")
      entry = DesktopEntries.heuristicLookup(id)
    var icon = entry && entry.icon ? entry.icon : id
    var library = root.bar && root.bar.shell ? root.bar.shell.appLibrary : null
    return library ? library.iconSource(icon) : Quickshell.iconPath(icon, true)
  }

  function tooltipFor(windows) {
    var lines = []
    for (var i = 0; i < windows.length; i++) {
      var line = root.windowTitle(windows[i]) || root.windowAppId(windows[i])
      if (line.length === 0) continue
      if (line.length > root.maxTitleLength) line = line.slice(0, root.maxTitleLength - 1) + "…"
      lines.push(line)
    }
    return lines.join("\n")
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : root.workspaceIds().length
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.workspaceIds()

      WidgetButton {
        id: button
        required property int modelData

        readonly property var workspace: root.workspaceById(modelData)
        readonly property var windows: workspace ? workspace.toplevels.values : []
        readonly property bool occupied: windows.length > 0
        readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData
        readonly property bool iconsShown: root.showIcons && !root.vertical && occupied

        bar: root.bar
        labelVisible: false
        hasVisualContent: true
        tooltipText: root.tooltipFor(windows)
        opacity: occupied || focused ? 1 : 0.5
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: root.vertical ? root.barSize
                                  : Math.max(Style.space(20), content.implicitWidth + Style.space(12))
        fixedHeight: root.barSize
        onPressed: function() { root.focusWorkspace(modelData) }

        Row {
          id: content
          anchors.centerIn: parent
          spacing: Style.spaceReal(4)

          Text {
            anchors.verticalCenter: parent.verticalCenter
            text: button.focused ? "󱓻" : (button.modelData === 10 ? "0" : String(button.modelData))
            color: button.foreground
            font.family: button.fontFamily
            font.pixelSize: Style.font.body
            renderType: Text.NativeRendering

            Behavior on color {
              enabled: !root.bar || root.bar.foregroundAnimationEnabled
              ColorAnimation { duration: 160 }
            }
          }

          Repeater {
            model: button.iconsShown ? button.windows : []

            Image {
              required property var modelData
              anchors.verticalCenter: parent.verticalCenter
              width: root.iconSize
              height: root.iconSize
              fillMode: Image.PreserveAspectFit
              asynchronous: true
              // Decode at physical pixels so PNG icons stay sharp on HiDPI.
              sourceSize.width: Math.round(root.iconSize * Screen.devicePixelRatio)
              sourceSize.height: Math.round(root.iconSize * Screen.devicePixelRatio)
              source: root.iconSourceFor(root.windowAppId(modelData))
            }
          }
        }
      }
    }
  }
}
