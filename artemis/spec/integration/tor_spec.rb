RSpec.describe "`artemis tor` command", type: :cli do
  it "executes `artemis help tor` command successfully" do
    output = `artemis help tor`
    expected_output = <<-OUT
Usage:
  artemis tor

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
