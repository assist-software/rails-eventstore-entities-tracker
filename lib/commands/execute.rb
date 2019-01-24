module Commands
  module Execute
    def execute(command)
      command.validate!
      handler_for(command).call(command)
    end

    private
    def handler_for(command)
      {
      }.fetch(command.class)
    end
  end
end