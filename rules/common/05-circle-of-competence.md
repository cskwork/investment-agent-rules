# 5. Stay in Your Circle of Competence

> "Risk comes from not knowing what you're doing."
> — Warren Buffett

> "Know what you own, and know why you own it."
> — Peter Lynch, *One Up on Wall Street*

## In short

Only own a business you can explain in plain language. If you cannot explain it, pass. Passing is a decision, not a failure.

## Why

The size of your circle of competence does not matter. The *honesty about its edge* does.

Most blow-ups happen outside that edge — in products the operator never tested under stress, in industries whose basic economics they cannot sketch on a napkin, in companies whose business they cannot explain in three sentences.

Peter Lynch said that everyday observation is a valid place to *start* an investment idea. But the observation is only the start. "I like the product" is a candidate, not a position. Without the numbers, the competition, and the management track record, it is just an anecdote.

An LLM-driven agent has the same problem in a sharper form. The model will happily reason about anything in its context window — including names where it has no real signal. *"Plausible-sounding"* is not the same as *"in the circle"*. The whole point of this rule is to refuse to act on prose that sounds analytical but is not.

## Checklist

- [ ] The list of investable names is *whitelisted* — not "anything the broker happens to list".
- [ ] For each name in the universe, the agent can answer: what drives revenue, who the customers are, who competes, and what could permanently impair the business.
- [ ] Adding a new name to the universe requires explicit onboarding (history, business model, key risks) before it becomes investable.
- [ ] If the agent cannot explain a name in plain language, it passes. Passing is a decision, not a failure — and is preferred to a low-conviction position.
- [ ] The agent does not promote a hunch into a thesis by adding research-flavored words.

## How an AI investment agent enforces this

```python
INVESTABLE_UNIVERSE = load_whitelist("config/universe.yaml")  # name + reason + last review

def in_circle(name):
    if name not in INVESTABLE_UNIVERSE:
        return False
    entry = INVESTABLE_UNIVERSE[name]
    if days_since(entry.last_review) > 180:
        return False  # stale — needs re-review
    if not entry.has_business_model_summary:
        return False  # no understanding → not in the circle
    return True
```

Exploration outside the circle happens in research mode, not in production. Promotion requires a written understanding the agent can defend in plain language.
