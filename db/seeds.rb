# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

   bill_1 =   Bill.create!(
      bill_id: "hr6395-116",
      summary_short:
      "To authorize appropriations for fiscal year 2021 for military activities of the Department of Defense and for military construction, to prescribe military personnel strengths for such fiscal year, and for other purposes.",
      congress_url: "https://www.congress.gov/bill/116th-congress/house-bill/6395",
      short_title: "William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021",
      primary_subject: "Armed Forces and National Security"
    )

    bill_2 =   Bill.create!(
      bill_id: "hr1957-116",
      summary_short:
      "Great American Outdoors Act This bill establishes the National Parks and Public Land Legacy Restoration Fund to support deferred maintenance projects on federal lands.  For FY2021-FY2025, there shall be deposited into the fund an amount equal to 50% of energy development revenues credited, covered, or deposited as miscellaneous receipts from oil, gas, coal, or alternative or renewable energy development on federal lands and waters. Deposited amounts must not exceed $1.9 billion for any fiscal...",
      congress_url: "https://www.congress.gov/bill/116th-congress/house-bill/1957",
      short_title: "Great American Outdoors Act",
      primary_subject: "Armed Forces and National Security",
      created_at: "Tue, 28 Jul 2020 19:37:05 UTC +00:00",
      updated_at: "Tue, 28 Jul 2020 19:37:05 UTC +00:00")
      
    bill_3 =   Bill.create!(
      bill_id: "s4049-116",
      summary_short:
      "To authorize appropriations for fiscal year 2021 for military activities of the Department of Defense and for military construction, to prescribe military personnel strengths for such fiscal year, and for other purposes.",
      congress_url: "https://www.congress.gov/bill/116th-congress/house-bill/6395",
      short_title: "William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021",
      primary_subject: "Armed Forces and National Security"
     )

    senate_bill_vote1 = SenateBillVote.create!(roll_call: 140, offset: 0, bill: bill_2)
