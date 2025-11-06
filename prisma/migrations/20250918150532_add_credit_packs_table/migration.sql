-- Ensure Plan table indexes match Prisma schema
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_indexes
    WHERE schemaname = 'public'
      AND indexname = 'Plan_sortOrder_idx'
  ) THEN
    EXECUTE 'CREATE INDEX "Plan_sortOrder_idx" ON "public"."Plan"("sortOrder")';
  END IF;
END $$;

-- Reassert defaults on Plan.highlight and Plan.billingSource in case of drift
ALTER TABLE "public"."Plan"
  ALTER COLUMN "highlight" SET DEFAULT false,
  ALTER COLUMN "billingSource" SET DEFAULT 'clerk',
  ALTER COLUMN "sortOrder" SET DEFAULT 0,
  ALTER COLUMN "sortOrder" SET NOT NULL;

-- Reassert default on Plan.ctaType to align with @default in schema
ALTER TABLE "public"."Plan"
  ALTER COLUMN "ctaType" SET DEFAULT 'checkout';
