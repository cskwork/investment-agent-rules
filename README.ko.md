# AI 투자 에이전트를 위한 10계명

[English](README.md) | **한국어**

자금을 다루는 AI 에이전트(시그널 생성, 사이징, 주문 집행 무관)를 위한 최소 드롭인 규칙 모음. 출처는 그 비용을 직접 치른 사람들이다:

Buffett, Munger, Graham, Lynch, Dalio, Marks, Soros, Druckenmiller, Simons, Greenblatt.

10개 규칙. 한국 시장 오버레이 1개. 퀀트 봇 enforcement 맵 1개. 군더더기 없음.

## 왜 필요한가

LLM 기반 트레이딩 에이전트는 예측 가능한 방식으로 망가진다:

- 모든 시그널을 동일한 사이즈로 집행 — 컨빅션도 사이클도 무시.
- 합의(consensus)를 그대로 따르고 그걸 "리서치"라고 부른다.
- "좋은 thesis"가 있으면 가격은 무시해도 된다고 착각한다.
- 내러티브가 아직 살아있다는 이유로 손실 종목에 평단을 낮춘다(물타기).
- 운으로 번 결과를 "작동하는 프로세스"로 혼동한다.
- 베타가 같은 30종목을 분산이라고 부른다.
- 손실을 합리화하려고 세션 도중에 자기 리스크 룰을 수정한다.
- 백테스트 엣지를 out-of-sample 검증 없이 그대로 가져간다.

아래 10계명 — 그리고 *Korean Equity Overlay*, *Quant-Bot Enforcement Map* — 이 모든 실패 모드를 막는 최소 룰 모음이다.

## 설치

### 한 줄 설치 (권장)

```bash
git clone https://github.com/cskwork/investment-agent-rules.git ~/investment-agent-rules
cd ~/investment-agent-rules && ./install.sh
```

`~/.claude/rules/investment/` 아래에 떨어진다. 프로젝트 `CLAUDE.md` / `AGENTS.md`에서 참조:

```markdown
@~/.claude/rules/investment/common/00-index.md
@~/.claude/rules/investment/kr-equity/00-kr-equity-overlay.md
@~/.claude/rules/investment/quant-bot/00-bot-enforcement.md
```

### 부분 설치

```bash
./install.sh common      # 10계명만
./install.sh kr-equity   # 한국 시장 오버레이만
./install.sh quant-bot   # 봇 enforcement 맵만
```

### 설치 경로 변경

```bash
INVESTMENT_RULES_DEST=~/my/path ./install.sh
```

## 10계명

1. **자본 보존이 먼저.** 영구 손실 금지. 50% 손실은 100% 수익이 있어야 회복된다. — *Buffett, Rule No. 1*
2. **안전마진 (Margin of Safety).** 내재가치보다 충분히 낮은 가격에 사라. 그 차이가 네 모델의 오차를 흡수한다. — *Graham, Buffett*
3. **능력의 범위 (Circle of Competence).** 설명할 수 있는 것만 매매하라. 화이트리스트가 봇의 circle이다. "모른다"는 유효한 행동이다. — *Buffett, Lynch*
4. **2차원적 사고 (Second-Level Thinking).** 합의는 이미 가격에 들어있다. 엣지는 "사실"과 "시장이 믿는 것" 사이의 간극에 있다. 거꾸로 생각해라. — *Marks, Munger*
5. **사이클과 재귀성 (Reflexivity).** 시장은 자기 자신에게 피드백된다. 도취 국면에서는 사이즈를 *줄여라* — 늘리지 마라. — *Marks, Soros*
6. **포지션 사이징과 비대칭성.** 사이즈는 stop 거리로 산정한다 — 종목 수로 산정하지 않는다. 보상/위험 2:1 미만이면 진입 금지. — *Druckenmiller*
7. **확신은 집중, 무지는 분산.** 둘 다 맞다. 상관관계가 높은 30종목은 분산이 아니다. — *Buffett, Dalio*
8. **장기 복리 > 단기 매매.** 가장 큰 누수는 종목 선정이 아니라 회전율이다. 시그널 없으면 트레이드 없음. — *Buffett, Munger*
9. **결과보다 프로세스.** out-of-sample로 시그널을 검증하고, 모든 것을 로깅하고, 지난주 P&L이 아닌 프로세스로 판단하라. — *Simons, Greenblatt*
10. **행동 규율 (Behavioral Discipline).** Mr. Market은 패닉한다. 봇은 패닉하지 않는다. 세션 도중 룰 변경 금지. 킬 스위치는 기능이다. — *Graham, Munger*

각 규칙의 전체 본문, 체크리스트, "AI 트레이딩 봇이 이걸 어떻게 강제하는가" 의사코드는 [`rules/common/`](rules/common/00-index.md) 에 있다.

## 저장소 구조

```
investment-agent-rules/
├── README.md
├── README.ko.md
├── LICENSE                       # MIT
├── install.sh                    # rules/ 를 ~/.claude/rules/investment/ 로 복사
└── rules/
    ├── common/                   # 10계명 (파일당 1개)
    │   ├── 00-index.md
    │   ├── 01-capital-preservation.md
    │   ├── 02-margin-of-safety.md
    │   ├── 03-circle-of-competence.md
    │   ├── 04-second-level-thinking.md
    │   ├── 05-cycles-and-reflexivity.md
    │   ├── 06-position-sizing-and-asymmetry.md
    │   ├── 07-concentration-vs-diversification.md
    │   ├── 08-long-term-compounding.md
    │   ├── 09-process-over-outcome.md
    │   └── 10-behavioral-discipline.md
    ├── kr-equity/                # 한국 시장 특화
    │   └── 00-kr-equity-overlay.md
    └── quant-bot/                # 계명 → 코드 게이트 매핑
        └── 00-bot-enforcement.md
```

## 설계 노트

- **명령형, 권고형 X.** 모든 계명은 지시문이자 게이트다 — 가치 진술이 아니다.
- **중요한 곳엔 의사코드.** 원칙은 끄덕이기는 쉽고 강제하기는 어렵다. 각 계명 끝에 그것을 강제하는 게이트를 둔다.
- **시장 무관 코어 + 시장 특화 오버레이.** 10계명은 어디서나 통한다. KR 오버레이는 한국 현물주식의 차이점(세금, 결제, 단일가, VI)을 인코딩한다.
- **LLM은 제안, 코드는 처분.** 퀀트 봇 오버레이는 "LLM이 루프에 있다 = 기본적으로 안전하지 않다"는 전제로 만들었다. 게이트가 안전장치다.
- **코어에 도구 이름 없음.** `pandas`도, `ccxt`도, 특정 브로커도 없다. 원칙은 어느 한 스택보다 오래 가야 한다.

## 동반 프로젝트

이 룰셋은 AI 기반 한국 주식 트레이딩 봇 [`kr-ai-trader`](https://github.com/cskwork/kr-ai-trader) 의 규율을 정의한다. 룰이 먼저, 코드가 나중이다 — 의도된 순서다.

## 커스터마이징

Fork. `rules/common/`은 마지막에 손대고, 오버레이와 enforcement 맵부터 손대라.

새 규칙은:
- 맨 위는 한 문장. 그 아래에 체크리스트와 코드 게이트.
- 누군가 실제로 비용을 치른 실패 모드에 대응해야 한다.
- 기존 규칙과 중복되지 않아야 한다.

15계명을 넘으면 그건 룰셋이 아니라 교과서다.

## 면책 (Disclaimer)

교육 목적의 참고 자료다. 투자 자문이 아니다. 시장은 이 문서가 예상하지 못한 방식으로도 손실을 만든다. 저자는 너의 fiduciary가 아니다.

## 라이선스

MIT. [LICENSE](LICENSE) 참조.
