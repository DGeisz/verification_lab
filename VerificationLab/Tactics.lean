syntax "return_with_proof" term : tactic

macro_rules
  | `(tactic| return_with_proof $a:term) => `(tactic| apply Subtype.mk (val := $a))

syntax "with_proof" term : tactic

macro_rules
  | `(tactic| with_proof $a:term) => `(tactic| apply Subtype.mk (val := $a))
