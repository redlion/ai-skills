# ai-skills

Agent skills for planning, stress-testing ideas, and handing work off between sessions.

## Install (Claude Code)

```
/plugin marketplace add redlion/ai-skills
/plugin install ai-skills@redlion
```

Or in one step on Claude Code 2.1.275 or later:

```
/plugin install ai-skills --marketplace redlion/ai-skills
```

## Skills

### User-invoked

- [grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md): A relentless interview to sharpen a plan or design, which also creates docs (ADRs and glossary) as we go.
- [grill-me](./skills/productivity/grill-me/SKILL.md): A relentless interview to sharpen a plan or design.
- [handoff](./skills/productivity/handoff/SKILL.md): Compact the current conversation into a handoff document for another agent to pick up.

### Model-invoked

- [domain-modeling](./skills/engineering/domain-modeling/SKILL.md): Build and sharpen a project's domain model: glossary and ADRs.
- [grilling](./skills/productivity/grilling/SKILL.md): Grill the user relentlessly about a plan, decision, or idea.
