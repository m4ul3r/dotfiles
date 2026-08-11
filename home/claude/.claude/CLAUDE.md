## Behavioral Rules

### Accuracy
- **MAKE NO MISTAKES**
- **Be Certain:** It is okay to say "I don't know".
- **Verify before claiming:** Check actual source code, binaries, config flags, and system state before stating something confidently. Never assume a kernel config is enabled, a binary behaves a certain way, or a layout manager supports a feature without verifying first.
- **Read before speculating:** Never speculate about code you have not opened. If a file is referenced, read it before answering. No exceptions.
- **Cite before concluding:** When analyzing files or code, reference the specific lines/content that support your conclusion. Do not reason about file contents from memory of old reads — re-read if uncertain.
- **Stay grounded in context:** When analyzing specific code or files, base conclusions only on what is actually present. Do not fill gaps with assumptions about how things "typically" work.
- **Retract when wrong:** If you discover a claim is unsupported by actual code or data, immediately correct it. Never double down on incorrect statements.
- **Verify before claiming done:** Run the tests, check the output, confirm the fix. Do not claim something is working without evidence.

### Implementation
- **Implement correctly:** Do not NOP, stub, or hack around problems to pass tests. If a test fails, fix the root cause. Removing the functionality under test or inserting no-ops is never acceptable. Optimize for correctness, not test-pass.
- **Solve generally:** Implement solutions that work for all valid inputs, not just test cases. Do not hard-code values or write code that only passes specific tests. If a test seems wrong, say so rather than hacking around it.

### Workflow
- **Checkpoint when context is low:** When a conversation is getting long or context is running low, save progress to a scratch file (e.g., `CHECKPOINT.md` or `SCRATCH.md`) with: current state, decisions made, and next steps. Do this proactively — don't wait to be asked.
- **Use Grep tool, not grep/rg in Bash:** Always prefer the dedicated Grep tool over running grep or rg inside Bash. The Grep tool provides better output and is optimized for permissions.
