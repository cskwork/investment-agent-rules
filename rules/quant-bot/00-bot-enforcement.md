# Quant-Bot Enforcement Map

How each of the Ten Commandments becomes deterministic code in an AI-driven trading bot.

LLMs reason. Code enforces. Anywhere an LLM is in the decision path, a deterministic gate sits *after* the LLM and *before* the broker. The LLM proposes; the gate disposes.

## Architecture (the only diagram you need)

```
   ┌──────────────┐    proposal     ┌──────────────┐   approved order   ┌──────────┐
   │ LLM / signal │ ───────────────▶│ risk gates   │ ──────────────────▶│ broker   │
   │  generator   │                 │ (this layer) │                    │ adapter  │
   └──────────────┘                 └──────┬───────┘                    └────┬─────┘
                                           │ rejects + reasons               │ fills
                                           ▼                                 ▼
                                     immutable log ◀──── reconciliation ────┘
```

Three properties matter:
1. The LLM cannot bypass the gates. The gates are not advisory.
2. Every rejection is logged with a reason code.
3. Every fill is reconciled back against the proposal that triggered it.

## Commandment → gate

| # | Commandment | Deterministic gate | Reject reason codes |
|---|-------------|--------------------|---------------------|
| 1 | Capital preservation | `pre_trade_guard.can_open()` | `daily_loss_cap`, `per_trade_loss_cap`, `min_equity_floor` |
| 2 | Margin of safety | `passes_margin_of_safety()` | `entry_above_fair_value`, `margin_too_thin_for_noise` |
| 3 | Circle of competence | `in_circle(ticker)` | `not_in_universe`, `review_stale`, `liquidity_below_floor` |
| 4 | Second-level thinking | `edge_check(signal, consensus)` | `no_edge_over_consensus`, `no_invalidation_written` |
| 5 | Cycles & reflexivity | `regime_adjusted_size()`, `detect_reflexivity()` | `regime_haircut`, `reflexive_feedback_detected` |
| 6 | Position sizing | `size_position()`, `asymmetry_ok()` | `reward_risk_below_2`, `position_above_cap` |
| 7 | Concentration / diversification | `gross_cap_for_book()`, `conviction_concentration_ok()` | `correlation_cluster`, `unearned_concentration` |
| 8 | Long-term compounding | `turnover_guard()`, `net_alpha_alive()`, `has_signal()` | `turnover_budget`, `negative_net_alpha`, `no_signal_no_trade` |
| 9 | Process over outcome | `promote_to_live()`, `divergence_alarm()` | `oos_insufficient`, `live_diverges_from_expected` |
| 10 | Behavioral discipline | `behavioral_brake()`, `rule_change_guard()` | `consecutive_losses`, `daily_dd`, `model_drift`, `immutable_during_session` |

Each gate maps to one file under `bot/risk/gates/` (suggested layout, not prescribed). Each rejection writes a row with `(timestamp, gate, reason_code, payload_hash)` so behaviour is auditable after the fact.

## The non-negotiables

These are not opinions. A bot that violates any of them is unsafe and must not run with real capital:

1. **No silent overrides.** Every gate can be overridden by a human, but every override is signed, dated, logged, and visible in the next-day report.
2. **No rule edits in-session.** Configuration changes during a live session are rejected by `rule_change_guard()`.
3. **No "auto-tuning" against live P&L.** The bot does not change thresholds because it lost yesterday. Parameter changes go through the same OOS validation as the strategy itself.
4. **Immutable, append-only log.** Signals, proposals, rejections, fills, P&L attributions — all written once, never edited.
5. **A kill switch the operator can hit in under one second.** It cancels resting orders, blocks new entries, and leaves existing positions for human decision.

## What the LLM is allowed to do

- Generate hypotheses (signals, theses, sizing suggestions).
- Explain decisions in natural language for the human.
- Read logs and write post-mortems.
- Edit configuration *outside* a live session, under version control.

## What the LLM is not allowed to do

- Bypass a gate by retrying with a different prompt until the order goes through.
- Edit risk configuration during a live session.
- Send orders that have not passed the gates.
- Mark its own homework — backtest validation runs in a separate process with separate code paths.

The Ten Commandments tell the bot what discipline looks like. This file is how the discipline is non-optional.
