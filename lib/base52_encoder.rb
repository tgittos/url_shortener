class Base52Encoder
    class << self
        BASE52_CHARS = ('a'..'z').to_a.concat(('A'..'Z').to_a)

        def encode(id)
            encoded = ''
            if (id == 0)
                return BASE52_CHARS[0]
            end
            while id > 0 do
                idx = id % BASE52_CHARS.length
                encoded << BASE52_CHARS[idx]
                id = id / BASE52_CHARS.length
            end
            encoded.reverse
        end

        def decode(base52)
            decoded = 0
            place = 0
            base52.reverse.split('').each do |c|
                idx = BASE52_CHARS.index(c)
                decoded += idx * (BASE52_CHARS.length ** place)
                place += 1
            end
            decoded
        end
    end
end