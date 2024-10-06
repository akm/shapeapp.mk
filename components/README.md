# components

level | directory name | 日本語 | internal include | external include | target
-----:|---------------|-------|:----------------:|:----------------:|-------
2 | atoms      | 原子      | NO     | NO     | 
3 | molecules  | 分子      | YES    | NO     |
5 | organelles | 細胞小器官 | YES/NO | YES    |
8 | organs     | 器官・臓器 | YES/NO | YES/NO | application modules such as applib, biz, apisvr or uisvr
10 | organisms | 生物・有機体 | YES/NO | YES/NO | direcotries for local dev/test or deployment

- external include: include 元の .mk のディレクトリの外部の .mk を include する場合
- internal include: include を含まない、あるいは include 元の .mk のディレクトリ内部の .mk を include する（= 外部 include でない）
