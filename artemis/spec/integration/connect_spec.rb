RSpec.describe "`artemis connect` command", type: :cli do
  it "executes `artemis help connect` command successfully" do
    output = `artemis help connect`
    expected_output = <<-OUT
Usage:
  artemis connect

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
