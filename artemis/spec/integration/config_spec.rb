RSpec.describe "`artemis config` command", type: :cli do
  it "executes `artemis help config` command successfully" do
    output = `artemis help config`
    expected_output = <<-OUT
Usage:
  artemis config

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
