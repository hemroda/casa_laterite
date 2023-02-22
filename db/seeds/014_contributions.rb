# frozen_string_literal: true

if Contribution.count.zero?
  p "Seeding First Contribution"

  Contribution.create(
    name: "Rabezafy's first contribution to Property",
    amount: 2000000,
    account_id: 1,
    contributable_type: "Property",
    contributable_id: 1,
    contribution_type: 0
  )
  Contribution.create(
    name: "Rabezafy's second contribution to Property",
    amount: 2000000,
    account_id: 1,
    contributable_type: "Property",
    contributable_id: 2,
    contribution_type: 0
  )

  p "Seeding first Payment"
  Payment.create(
    amount: 20000,
    name: "February contribution's #1 payment",
    status: :no_invoice,
    payable_type: "Contribution",
    payable_id: 1,
    created_by_type: "User",
    created_by_id: 1,
    )
end
