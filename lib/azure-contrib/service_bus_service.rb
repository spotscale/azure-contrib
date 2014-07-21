module Azure
  class ServiceBusService
      # TODO: This needs to be moved to the contrib lib
    def find_or_create_topic(name)
      topic = self.list_topics.find {|topic| topic.name == name }
      topic = self.create_topic(name) if topic.nil?

      topic
    end

    # TODO: This needs to be moved to the contrib lib
    def find_or_create_subscription(topic, name)
      subscription = self.list_subscriptions(topic.name).find {|subscription| subscription.name == name }
      subscription = self.create_subscription(topic.name, name) if subscription.nil?

      subscription
    end
  end
end
