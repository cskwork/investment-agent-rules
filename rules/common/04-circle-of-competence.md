# 4. Stay in Your Circle of Competence

> "Risk comes from not knowing what you're doing."
> — Warren Buffett

> "Know what you own, and know why you own it."
> — Peter Lynch, *One Up on Wall Street*

## Why

The size of the circle of competence is not what matters. The honesty about its perimeter is.

Most blow-ups happen outside the perimeter — in instruments the operator never modeled in stress, in industries whose unit economics they cannot draw on a napkin, on names whose business model they cannot explain in three sentences.

Peter Lynch made the case that ordinary observation is a valid source of investment ideas — but he also insisted that observation is the beginning of research, not the end. "I like the product" is a candidate, not a position. Without the financials, the competitive landscape, and the management track record, it remains an anecdote.

An LLM-driven agent has the same problem with sharper edges: it will happily reason about anything in its context window, including names where it has no genuine analytical signal. "Plausible-sounding" is not the same as "in the circle."

## Checklist

- [ ] The universe of investable assets is *whitelisted* — not "anything the broker lists."
- [ ] For each name in the universe, the agent can answer: what drives revenue, who the customers are, who competes, what could destroy the business.
- [ ] Adding a new name requires explicit onboarding (history, business understanding, key risks) before it becomes investable.
- [ ] "I don't know" is a valid action and is preferred to a low-conviction position.
- [ ] The agent does not promote a hunch into a thesis by adding more research-flavored words.

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
