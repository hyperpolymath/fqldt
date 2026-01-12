-- SPDX-License-Identifier: PMPL-1.0
-- SPDX-FileCopyrightText: 2025 hyperpolymath
--
-- FqlDt - Dependently-Typed FormDB Query Language
--
-- This module provides compile-time verification of database constraints
-- through dependent types, enabling:
-- - Bounded values (BoundedNat, BoundedFloat)
-- - Non-empty strings (NonEmptyString, Rationale)
-- - Provenance tracking (Tracked)
-- - PROMPT score verification (PromptScores)

-- Core refinement types
import FqlDt.Types.BoundedNat
import FqlDt.Types.BoundedInt
import FqlDt.Types.NonEmptyString
import FqlDt.Types.Confidence

-- PROMPT score types
import FqlDt.Prompt.PromptDimension
import FqlDt.Prompt.PromptScores

-- Provenance tracking
import FqlDt.Provenance.ActorId
import FqlDt.Provenance.Rationale
import FqlDt.Provenance.Tracked

-- FFI Bridge (Zig bindings)
-- Note: Requires libfdb_bridge.a to be linked for runtime use
import FqlDt.FFI.Bridge

-- FQL Query Language
import FqlDt.Query
