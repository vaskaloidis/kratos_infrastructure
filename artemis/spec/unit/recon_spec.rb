require 'artemis/commands/recon'

RSpec.describe Artemis::Commands::Recon do
  it "executes `recon` command successfully" do
    output = StringIO.new
    options = {}
    command = Artemis::Commands::Recon.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
