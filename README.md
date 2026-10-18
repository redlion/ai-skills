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

### From the private repo

Claude Code clones the marketplace with `git`, so any computer with git access to this repo can install it.

1. Check that git can reach the repo:

   ```
   git ls-remote git@github.com:redlion/ai-skills.git
   ```

   If you get a permission error, add an SSH key for this computer to your GitHub account, or run `gh auth login`.

2. Add the marketplace over SSH and install the plugin:

   ```
   /plugin marketplace add git@github.com:redlion/ai-skills.git
   /plugin install ai-skills@redlion
   ```

To pull updates, run `/plugin marketplace update redlion`. Background auto-updates of a private repo may need a GitHub token in your environment (`GITHUB_TOKEN` or `GH_TOKEN`).

## Skills

### User-invoked

- [grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md): A relentless interview to sharpen a plan or design, which also creates docs (ADRs and glossary) as we go.
- [grill-me](./skills/productivity/grill-me/SKILL.md): A relentless interview to sharpen a plan or design.
- [handoff](./skills/productivity/handoff/SKILL.md): Compact the current conversation into a handoff document for another agent to pick up.

### Model-invoked

- [domain-modeling](./skills/engineering/domain-modeling/SKILL.md): Build and sharpen a project's domain model: glossary and ADRs.
- [grilling](./skills/productivity/grilling/SKILL.md): Grill the user relentlessly about a plan, decision, or idea.
