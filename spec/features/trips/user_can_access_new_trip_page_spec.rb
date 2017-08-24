describe "User can access new trip page" do
  it "and view form to create new trip" do

    visit '/trips/new'

    page.has_content?('Duration')
    page.has_content?('Start Date')
    page.has_content?('Start Station Name')
    page.has_content?('End Date')
    page.has_content?('End Station Name')
    page.has_content?('Bike ID')
    page.has_content?('Subcription Type')
    page.has_content?('Zip Code')
  end
  it "and create new trip" do

    station1 = Station.create(name: "Panera",
                   dock_count: 15,
                   city: "Denver",
                   installation_date: "2014-04-09")
    station2 = Station.create(name: "Turing",
                   dock_count: 15,
                   city: "Denver",
                   installation_date: "2014-04-09")
    # require 'pry'; binding.pry

    visit '/trips/new'

    fill_in("trip[duration]", with: 173)
    fill_in("trip[start_date]", with: "2014-08-21 09:08:00")
    fill_in("trip[end_date]", with: "2015-08-22 09:08:00")
    select('Panera', :from => 'start-name-drop-down')
    select('Turing', :from => 'end-name-drop-down')
    select("#{station1.id}", :from => 'start-id-drop-down')
    select("#{station1.id}", :from => 'end-id-drop-down')
    fill_in("trip[bike_id]", with: 299)
    fill_in("trip[subscription_type]", with: "Subscriber")
    fill_in("trip[zip_code]", with: "90210")
    click_on("Create New Trip")

    expect(page).to have_content("173")
    expect(page).to have_content("Panera")
    expect(page).to have_content("Turing")
    expect(page).to have_content("Subscriber")
    expect(page).to have_content("90210")
    expect(current_path).to eq('/trips/1')
  end
end
