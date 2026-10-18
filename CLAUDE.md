Skills are organized into bucket folders under `skills/`:

- `engineering/`: daily code work
- `productivity/`: daily non-code workflow tools
- `misc/`: kept around but rarely used, not promoted
- `in-progress/`: beta: public on purpose, feedback wanted, not shipped in the plugin
- `deprecated/`: no longer used

Only `engineering/` and `productivity/` exist today. Create the other buckets when the first skill needs one.

Each skill is a folder holding a `SKILL.md`, an `agents/openai.yaml` (Codex metadata: `interface.display_name` and `interface.short_description`), and any supporting files the `SKILL.md` links to.

## The plugin

The whole repo is one Claude Code plugin, `ai-skills`, distributed through the repo's own marketplace, `redlion`:

- `.claude-plugin/plugin.json` lists the shipped skills in its `skills` array.
- `.claude-plugin/marketplace.json` defines the `redlion` marketplace with the repo root as the plugin source.

Every skill in `engineering/` or `productivity/` (the **promoted** buckets) must have an entry in `plugin.json`'s `skills` array and in the top-level `README.md`: the plugin ships exactly the promoted set. Skills in `misc/`, `in-progress/`, and `deprecated/` must not appear in either.

Run `claude plugin validate .` after touching either manifest. It should pass with exactly one warning, that `CLAUDE.md` at the plugin root is not loaded as plugin context. That warning is expected (this file is for working on the repo, not for plugin users), so don't use `--strict`, which turns it into a failure.

Bump `version` in `plugin.json` when shipping a change to a promoted skill, so installed copies update.

## README

The top-level `README.md` holds the install commands and lists every promoted skill with a one-line description, the skill name linked to its `SKILL.md`. Entries are grouped into **User-invoked** and **Model-invoked**.

## Invocation

Every `SKILL.md` is either:

- **user-invoked**: `disable-model-invocation: true` in the `SKILL.md` frontmatter plus `policy.allow_implicit_invocation: false` in `agents/openai.yaml`. Only the human can trigger it.
- **model-invoked**: neither setting. The model or the user can trigger it.

Keep the two files in agreement.

## Calling other skills

When a skill tells the agent to call another skill, give both names, because plugin installs prefix skill names and symlinked installs don't: "Call the Skill tool with "grilling" (named "ai-skills:grilling" when installed from the ai-skills plugin; use whichever name is in your skill list)." Every skill named this way must exist in this repo.

## Docs pages

Skills in `engineering/` and `productivity/` have a human-facing docs page at `docs/<bucket>/<skill-name>.md` (the docs tree mirrors those two bucket folders). When you add, rename, or change the behaviour of a promoted skill, create or re-sync its page. A page has a `# <skill-name>` heading followed by these four sections, in order:

1. **What it does**: what the skill does and what it produces, in a short paragraph.
2. **When to reach for it**: the situations it fits, and when a different skill fits better.
3. **Common questions**: questions a first-time user is likely to ask, each answered briefly.
4. **It's working if**: observable signs the skill is behaving as intended.

Skills in `misc/`, `in-progress/`, and `deprecated/` get no docs page. The one exception is a promoted skill removed outright: its page stays, with a note at the top that the skill is archived.

## Local install by symlink

To (re)link every skill outside `deprecated/` and `misc/` into the local harness skill directories (`~/.claude/skills`, `~/.agents/skills`), run `scripts/link-skills.sh`. Each entry is a symlink into this repo, so a `git pull` keeps installed skills current. Re-run the script after adding, removing, or renaming a skill. Don't combine this with installing the plugin in Claude Code, or every skill shows up twice (`grilling` and `ai-skills:grilling`).

## Style

No em-dashes anywhere in this repo's prose (`SKILL.md` files, docs, `README.md`, code comments). Where a sentence reaches for one, rewrite it with a comma, colon, period, parentheses, or a conjunction, whichever the sentence actually wants; never do a blind character substitution.
