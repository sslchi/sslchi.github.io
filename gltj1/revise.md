## 概率论第一章勘误：

- 21页 事件的运算之对立事件 $\emptyset -A \Longrightarrow \Omega -A$.

- 21页 事件的运算之对立事件性质1 $A-B=A\cap B\Longrightarrow A - B = A\cap \overline{B}$.

- 35页 性质5 应为： 对任一事件 $A$, 有 $P(\overline{A}) = 1 - P(A)$.

  > 证明：因为 $A \cup \overline{A} = \Omega$, 且 $A \cap \overline{A} = \emptyset$,  由有限可加性可得
  > $$1 = P(\Omega) = P(A \cup \overline{A}) = P(A) + P(\overline{A}),$$
  > 也即
  > $$P(\overline{A}) = 1 - P(A).$$

- 37页 推论2 应为 $\sum\limits_{k=1}^n P(A_i)$.

- 38页 例题应为：设$A, B$ 为两事件, $P(A) = 0.3$, $P(A \cup  B) = 0.6$, 求 $P(A\overline{B})$.

  > 解：易知
  > 	$$A\overline{B} = A(\Omega - B) = A - AB,$$
  > 故 
  > $$P(A\overline{B}) = P(A - AB) = P(A) - P(AB).$$
  >
  > 又因为 $$P(A \cup  B) = P(A) + P(B) - P(AB),$$ 
  > 所以
  > $$P(A) - P(AB) = P(A \cup  B) - P(B) = 0.6 - 0.3 = 0.3.$$

- 61页 例题小女孩概率的解答中， $A=\{(男，男)，(男，女)，(女，男)\}$应为$A=\{(男，男)，(男，女)，(女，男)\}$

- 63页 条件概率的定义，$P(B|A):=\dfrac{P(AB)}{P(B)}$应为 $P(B|A):=\dfrac{P(AB)}{P(B)}$.