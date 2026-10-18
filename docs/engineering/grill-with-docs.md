## What it does

`grill-with-docs` interviews you about a plan or design until you and the agent share one understanding of it, and writes the vocabulary and the hard decisions into your repo while it does. It is the same interview [grill-me](../productivity/grill-me.md) runs (a round of questions, then wait, then the next round), pointed at a codebase.

It is **stateful**. [grill-me](../productivity/grill-me.md) leaves the session in your head; this one leaves files on disk. When a term resolves, the skill writes it to `GLOSSARY.md` at once, not in a batch at the end. When a decision passes three gates, the skill writes it as an ADR. That is the whole difference, and it also causes most of the trouble people have with the skill. The artifacts are real files in a real repo, so they can be missing when you expected them, and they can drift when more than one person writes them.

## When to reach for it

You invoke this by typing `/grill-with-docs`, and the agent won't reach for it on its own.

Reach for it at the start of a change, in a repo, when the plan is still fuzzy and the words for the thing are not settled yet. It is a single-session tool. Which grilling skill you want depends on what is in front of you:

| What you have | Reach for |
| --- | --- |
| You aren't working in a working directory at all | [grill-me](../productivity/grill-me.md) |
| A repo, and a change you can settle in one session | `grill-with-docs` |
| A repo with no domain docs at all, and no particular feature in mind | `grill-with-docs`, aimed at the repo rather than a change |

If the effort is too big to settle in one session, break it into smaller pieces first and grill each one.

## Prerequisites

The skill writes into your repo, so you need to be somewhere it is safe to write. Resolved terms go to a `GLOSSARY.md` glossary at the root, or to the relevant context's `GLOSSARY.md`, if a `GLOSSARY-MAP.md` at the root marks the repo as multi-context. Decisions go to `docs/adr/`. The skill creates both only when it needs them. Nothing exists until the first term or decision is settled, so you set up nothing in advance.

It also needs two other skills present, because its own `SKILL.md` is one line that delegates to them. [grilling](../productivity/grilling.md) supplies the interview, and [domain-modeling](./domain-modeling.md) supplies the writing. Installing the `ai-skills` plugin, or running `scripts/link-skills.sh`, installs all three.

## The paper trail

Three things come out of a session, and they are not equal.

| What resolved | Where it lands |
| --- | --- |
| A term: the project's own word for a thing | `GLOSSARY.md`, inline, the moment it resolves |
| A decision that is hard to reverse, surprising without context, and a real trade-off | An ADR under `docs/adr/` |
| Everything else you decided | The conversation, and nowhere else |

That third row is the one that catches people out. `GLOSSARY.md` is only a glossary. It holds no implementation details, no spec, and no scratch notes. An ADR needs all three conditions at once, so most decisions do not qualify and most sessions produce none. A session that yields a sharper glossary and zero ADRs is working as designed, but it means most of what you agreed exists only in the context window you agreed it in. Before you clear the conversation, ask the agent to write those decisions down (a spec or plan in the same conversation), or run `/handoff` to carry them to the next session.

The glossary is the main output. This skill builds domain language: the project's own words, agreed once, so you, the agent and your colleagues do not have to work them out again. Not everyone agrees that this improves agent performance. The strongest objection is that a term and its plain-English expansion get the same result from the model, and that the vocabulary mainly shortens communication between the humans who share it. On that view the glossary is still valuable, but the value goes to the humans.

## Common questions

**It ran, but no `GLOSSARY.md` and no ADRs appeared.**
The usual cause is that nothing qualified. ADRs need all three gates, and a session about a change with no new vocabulary has nothing to write. The other cause is that `domain-modeling` never loaded (see the next question). When the skill runs inside another orchestration layer (a spec-driven-development wrapper, a multi-agent framework, a rule that invokes it as a step in someone else's pipeline), check the working directory before you trust the session's output.

**It asked everything at once, with no recommendations, and never mentioned `GLOSSARY.md`.**
That is the skill failing to load its two dependencies. Because `SKILL.md` is a one-line delegation, an agent that does not pick up [grilling](../productivity/grilling.md) and [domain-modeling](./domain-modeling.md) guesses at what grilling means, and you get every question at once with no structure. Partial loading is more confusing. `grilling` loads, `domain-modeling` does not, and you get a good interview with no paper trail. How often it happens depends on the model and the effort level. If you suspect it, ask the agent directly which skills it loaded.

**Where did all my other decisions go?**
Into the conversation only. The glossary is not a spec, most answers do not earn an ADR, and nothing links each resolved answer to a spec, a ticket and a test. Later steps can soften precise answers (ordering guarantees, negative requirements, numeric defaults) into weaker prose, and the result can look complete while missing the thing you decided. Have the agent write a spec in the same conversation, then re-read it against your own answers rather than assuming it captured them.

**Can I point it at an existing repo that has no docs at all?**
Yes. This is the right skill for a codebase with no ADRs, no domain language and no design principles: invoke it and say "help me document my repo". Expect to steer it. It reads code and asks you about what it finds, and you decide which of the words already in the codebase are the right ones.

**What should I do when the session ends?**
Keep the conversation. Turn what you agreed into a spec or plan in the same session, or build the change directly if it is small enough. If the work has to move to another session, harness or person, use `/handoff`.

## It's working if

- `GLOSSARY.md` changes *during* the session, term by term, rather than appearing in one lump at the end.
- The glossary reads as pure vocabulary (your project's words with tight definitions) and contains no implementation detail or spec-like prose.
- Questions the codebase can answer get answered by reading the codebase, not asked of you.
- You get few or no ADRs, and the ones you get are decisions you would be annoyed to have to argue again.
- It challenges a word you used because your existing glossary defines it differently.

## Where it fits

`grill-with-docs` comes before anything is written down as a spec. It produces the shared understanding and settled vocabulary that the rest of the work builds on. Its close neighbours are [grill-me](../productivity/grill-me.md), the same interview with no repo and no files, and [domain-modeling](./domain-modeling.md), the glossary-and-ADR discipline it drives; both use [grilling](../productivity/grilling.md) for the interview. When the work has to continue somewhere else, [handoff](../productivity/handoff.md) carries it.
