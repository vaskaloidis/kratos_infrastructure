RSpec.describe "`artemis deploy` command", type: :cli do
  it "executes `artemis help deploy` command successfully" do
    output = `artemis help deploy`
    expected_output = <<-OUT
Usage:
  artemis deploy

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
