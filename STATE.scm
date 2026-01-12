;; SPDX-License-Identifier: PMPL-1.0
;; SPDX-FileCopyrightText: 2025 hyperpolymath
;;
;; STATE.scm - Project state tracking for fdql-dt
;; Media-Type: application/vnd.state+scm

(state
  (metadata
    (version "0.1.0")
    (schema-version "1.0.0")
    (created "2025-01-12")
    (updated "2025-01-12")
    (project "fdql-dt")
    (repo "https://github.com/hyperpolymath/fdql-dt"))

  (project-context
    (name "FQLdt: Dependently-Typed FormDB Query Language")
    (tagline "Compile-time verification of database constraints via dependent types")
    (tech-stack
      (primary "Lean 4")
      (ffi "Zig")
      (config "Nickel")
      (containers "Podman/Nerdctl")))

  (current-position
    (phase "pre-implementation")
    (overall-completion 5)  ; specs complete, no code yet
    (components
      (specifications
        (status complete)
        (completion 100)
        (files
          "spec/FQL_Dependent_Types_Complete_Specification.md"
          "spec/normalization-types.md"
          "docs/WP06_Dependently_Typed_FormDB.md"))
      (lean4-project-setup
        (status not-started)
        (completion 0)
        (blocking mvp))
      (refinement-types
        (status not-started)
        (completion 0)
        (blocking mvp))
      (prompt-scores
        (status not-started)
        (completion 0)
        (blocking mvp))
      (provenance-tracking
        (status not-started)
        (completion 0)
        (blocking mvp))
      (zig-ffi-bridge
        (status not-started)
        (completion 0))
      (fql-parser
        (status not-started)
        (completion 0)))
    (working-features
      (container-build "justfile with nerdctl/podman/docker fallback")))

  (route-to-mvp
    (target-version "1.0.0")
    (definition "Phase 1: Refinement types working in Lean 4")

    (milestones
      (milestone-1
        (name "Lean 4 Project Setup")
        (status not-started)
        (items
          (item "Create lakefile.lean with Mathlib4 dependency")
          (item "Add lean-toolchain file (leanprover/lean4:v4.x.0)")
          (item "Create FqlDt/ source directory structure")
          (item "Update Dockerfile for Lean 4 + elan")
          (item "Verify lake build succeeds")))

      (milestone-2
        (name "Core Refinement Types")
        (status not-started)
        (depends-on milestone-1)
        (items
          (item "FqlDt/Types/BoundedNat.lean - BoundedNat min max structure")
          (item "FqlDt/Types/BoundedFloat.lean - BoundedFloat min max structure")
          (item "FqlDt/Types/NonEmptyString.lean - String with length > 0 proof")
          (item "FqlDt/Types/Confidence.lean - BoundedFloat 0.0 1.0 alias")
          (item "Unit tests for all type constructors")
          (item "Prove basic theorems (bounds preserved under arithmetic)")))

      (milestone-3
        (name "PROMPT Score Types")
        (status not-started)
        (depends-on milestone-2)
        (items
          (item "FqlDt/Prompt/PromptDimension.lean - BoundedNat 0 100 alias")
          (item "FqlDt/Prompt/PromptScores.lean - 6 dimensions struct")
          (item "Auto-computed overall field with correctness proof")
          (item "Smart constructor mkPromptScores")
          (item "Theorem: overall_in_bounds")))

      (milestone-4
        (name "Provenance Tracking")
        (status not-started)
        (depends-on milestone-2)
        (items
          (item "FqlDt/Provenance/ActorId.lean - NonEmptyString wrapper")
          (item "FqlDt/Provenance/Rationale.lean - NonEmptyString wrapper")
          (item "FqlDt/Provenance/Timestamp.lean - Timestamp type")
          (item "FqlDt/Provenance/Tracked.lean - Tracked alpha structure")
          (item "Theorem: tracked_has_provenance")))

      (milestone-5
        (name "Zig FFI Bridge")
        (status not-started)
        (depends-on milestone-3 milestone-4)
        (items
          (item "bridge/fdb_types.zig - FdbStatus, proof blob structs")
          (item "bridge/fdb_insert.zig - fdb_insert with proof_blob param")
          (item "Lean 4 @[extern] declarations")
          (item "Integration test: Lean calls Zig")))

      (milestone-6
        (name "Basic FQL Parser")
        (status not-started)
        (depends-on milestone-5)
        (items
          (item "Parse INSERT INTO ... VALUES ... WITH_PROOF {...}")
          (item "Type-check values against Lean 4 definitions")
          (item "Generate proof obligations")
          (item "Error messages with suggestions")
          (item "End-to-end test: FQL string -> type-checked insert")))))

  (blockers-and-issues
    (critical ())
    (high
      (issue
        (id "DECISION-001")
        (title "Lean 4 version selection")
        (description "Need to choose stable Lean 4 version compatible with Mathlib4")
        (action "Check mathlib4 compatibility matrix")))
    (medium
      (issue
        (id "DECISION-002")
        (title "Parser approach")
        (description "Hand-rolled vs parsec-style vs integrate with existing FQL parser")
        (options
          "Hand-rolled (simple, no deps)"
          "Lean 4 Parsec (built-in)"
          "Integrate with FormDB's Factor-based FQL parser")))
    (low
      (issue
        (id "DECISION-003")
        (title "FormDB integration strategy")
        (description "Mock Forth core for MVP, or wire to real Form.Bridge?")
        (recommendation "Mock for MVP, real integration in 1.1"))))

  (critical-next-actions
    (immediate
      (action "Create lakefile.lean with basic project structure")
      (action "Choose Lean 4 version (check Mathlib4 releases)"))
    (this-week
      (action "Implement BoundedNat with proofs")
      (action "Implement NonEmptyString with proofs"))
    (this-month
      (action "Complete Milestone 1-3 (refinement types + PROMPT scores)")
      (action "First proof: average of BoundedNat preserves bounds")))

  (session-history
    (snapshot
      (date "2025-01-12")
      (session-id "initial-analysis")
      (accomplishments
        "Analyzed repo structure and specifications"
        "Identified MVP 1.0 scope as Phase 1 (refinement types)"
        "Created STATE.scm with 6-milestone roadmap"
        "Documented decision points and blockers")
      (next-steps
        "Create Lean 4 project structure"
        "Implement first refinement type (BoundedNat)"))))

;; Helper functions for state queries
(define (get-completion-percentage state)
  (state 'current-position 'overall-completion))

(define (get-blockers state priority)
  (state 'blockers-and-issues priority))

(define (get-milestone state n)
  (state 'route-to-mvp 'milestones (string->symbol (format "milestone-~a" n))))
