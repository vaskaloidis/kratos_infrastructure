RSpec.describe "`artemis recon` command", type: :cli do
  it "executes `artemis help recon` command successfully" do
    output = `artemis help recon`
    expected_output = <<-OUT
Usage:
  artemis recon

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
