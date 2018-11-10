RSpec.describe "`artemis authenticate` command", type: :cli do
  it "executes `artemis help authenticate` command successfully" do
    output = `artemis help authenticate`
    expected_output = <<-OUT
Usage:
  artemis authenticate

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
