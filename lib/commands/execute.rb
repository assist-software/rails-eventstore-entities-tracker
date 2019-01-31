module Commands
  module Execute
    def execute(command)
      command.validate!
      handler_for(command).call(command)
    end

    private
    def handler_for(command)
      {
        Commands::Entities::CreateEntity => CommandHandlers::Entities::CreateEntity.new,
        Commands::Entities::EditEntity   => CommandHandlers::Entities::EditEntity.new,
        Commands::Entities::DeleteEntity => CommandHandlers::Entities::DeleteEntity.new,
      }.fetch(command.class)
    end
  end
end