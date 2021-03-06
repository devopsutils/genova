module Slack
  class DeployConfirmWorker
    include Sidekiq::Worker

    sidekiq_options queue: :slack_deploy_confirm, retry: false

    def perform(id)
      logger.info('Started Slack::DeployConfirmWorker')

      job = Genova::Sidekiq::Queue.find(id).options
      Genova::Slack::Bot.new.post_confirm_deploy(job)
    end
  end
end
