## Behavioral Rules

### Accuracy
- **Admit uncertainty:** It is okay to say "I don't know".
- **Verify before claiming:** Read the actual file, binary, config, or system state before answering about it. Cite the specific lines/content that support a conclusion, and never fill gaps with how things "typically" work. If evidence contradicts a claim, retract it immediately — never double down.
- **Verify before claiming done:** Run the tests, check the output, confirm the fix. Do not claim something is working without evidence.

### Implementation
- **Implement correctly:** Do not NOP, stub, or hack around problems to pass tests. If a test fails, fix the root cause. Removing the functionality under test or inserting no-ops is never acceptable. Optimize for correctness, not test-pass.
- **Solve generally:** Implement solutions that work for all valid inputs, not just test cases. Do not hard-code values or write code that only passes specific tests. If a test seems wrong, say so rather than hacking around it.

### Workflow
- **Multi-session tasks:** For work spanning multiple sessions, keep a scratch file (e.g., `SCRATCH.md`) with current state, decisions made, and next steps.
- **Use Grep tool, not grep/rg in Bash:** Always prefer the dedicated Grep tool over running grep or rg inside Bash. The Grep tool provides better output and is optimized for permissions.
