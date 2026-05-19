# 10. Behavioral Discipline — Manage the Operator, Not the Market

> "The investor's chief problem — and even his worst enemy — is likely to be himself."
> — Benjamin Graham

> "Mr. Market is there to serve you, not to guide you."
> — Benjamin Graham, *The Intelligent Investor*

> "The big money is not in the buying or the selling, but in the waiting."
> — Charlie Munger

## Why

Most losing trades are not signal failures. They are operator failures: revenge trade after a loss, FOMO entry after a missed move, "average down" out of pride, hold-the-loser because selling crystallizes being wrong.

An LLM-driven agent inherits a related set of pathologies: hallucinated confidence, story-driven reasoning that survives contradicting evidence, recency-weighted optimism, agreeable drift toward whatever the most recent prompt suggested.

The defense is the same in both cases: a written process, executed regardless of mood. The bot's job is to *be the discipline the human cannot reliably supply* — not to outsource its discipline to whoever is typing.

## Checklist

- [ ] All decisions are taken against the written process, not against the day's narrative.
- [ ] After a loss, no size-up. After a win, no size-up. Sizing is a function of the system, not the streak.
- [ ] Pre-committed circuit breakers: after N consecutive losses, daily DD, or model drift > threshold → stop, escalate to human.
- [ ] The bot does not change its rules mid-session. Rule changes are versioned, dated, and reviewed.
- [ ] The bot is allowed — and required — to say "no signal today" without apology.
- [ ] Human override of a risk gate is logged, signed, and reviewed; it is never silent.

## How an AI trading bot enforces this

```python
def behavioral_brake(session):
    if session.consecutive_losses >= 4:
        return Halt("4 consecutive losses — escalate")
    if session.realized_dd_today >= session.daily_dd_cap:
        return Halt("daily DD cap reached")
    if session.model_drift_score > session.drift_threshold:
        return Halt("model drift — re-validate before resuming")
    return Continue()

def rule_change_guard(new_config, old_config, actor):
    # No rule edits during a live session. Period.
    if session_is_live():
        raise ImmutableDuringSession()
    log_signed_change(diff=diff(old_config, new_config), actor=actor)
```

The agent's first loyalty is to the process. Mr. Market may panic. The bot does not.
