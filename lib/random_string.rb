class RandomString
    def self.generate
        ('A'..'Z').zip('a'..'z').flatten.to_a.shuffle[0,8].join
    end
end