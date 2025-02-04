"""create ping table

Revision ID: initial_migration
Revises: 
Create Date: 2025-02-02

"""
from alembic import op
import sqlalchemy as sa

revision = 'initial_migration'
down_revision = None
branch_labels = None
depends_on = None

def upgrade() -> None:
    op.create_table(
        'ping',
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.PrimaryKeyConstraint('created_at')
    )

def downgrade() -> None:
    op.drop_table('ping')