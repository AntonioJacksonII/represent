# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
Bill.create(
  bill_id: "hr6395-116",
  summary_short:
   "William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021 This bill authorizes FY2021 appropriations and sets forth policies for Department of Defense (DOD) programs and activities, including military personnel strengths. It does not provide budget authority, which is provided in subsequent appropriations legislation. The bill authorizes appropriations to DOD for  Procurement, including aircraft, weapons and tracked combat vehicles, shipbuilding and conversion, and m...",
  congress_url: "https://www.congress.gov/bill/116th-congress/house-bill/6395",
  short_title: "William M. (Mac) Thornberry National Defense Authorization Act for Fiscal Year 2021",
  primary_subject: "Armed Forces and National Security",
  offset: 0,
  passage_roll_call: 152)

  Bill.create(
    bill_id: "hr1957-116",
    summary_short:
     "Great American Outdoors Act This bill establishes the National Parks and Public Land Legacy Restoration Fund to support deferred maintenance projects on federal lands.  For FY2021-FY2025, there shall be deposited into the fund an amount equal to 50% of energy development revenues credited, covered, or deposited as miscellaneous receipts from oil, gas, coal, or alternative or renewable energy development on federal lands and waters. Deposited amounts must not exceed $1.9 billion for any fiscal...",
    congress_url: "https://www.congress.gov/bill/116th-congress/house-bill/1957",
    short_title: "Great American Outdoors Act",
    primary_subject: "Armed Forces and National Security",
    offset: 0,
    passage_roll_call: 153)
HouseMember.create!(first_name: 'Alexandria', last_name: 'Ocasio-Cortez', congress_id: "O000172")
