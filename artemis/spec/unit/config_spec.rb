require 'artemis/commands/config'

RSpec.describe Artemis::Commands::Config do
  it "executes `config` command successfully" do
    output = StringIO.new
    options = {}
    command = Artemis::Commands::Config.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
