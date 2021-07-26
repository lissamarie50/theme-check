# frozen_string_literal: true

# An in-memory storage is not written to disk. The reasons why you'd
# want to do that are your own. The idea is to not write to disk
# something that doesn't need to be there. If you have your template
# as a big hash already, leave it like that and save yourself some IO.
module ThemeCheck
  class InMemoryStorage < Storage
    def initialize(files = {}, root = "/dev/null")
      @files = files
      @root = Pathname.new(root)
    end

    def path(relative_path)
      @root.join(relative_path)
    end

    def read(relative_path)
      @files[relative_path]
    end

    def write(relative_path, content)
      @files[relative_path] = content
    end

    #create new touch method
    def touch(relative_path)
      dir = file(relative_path).dirname.to_s

      binding.pry

      unless File.directory?(dir)
        # FileUtils.mkdir_p(dir)
        file(relative_path).dirname.mkpath
      end
      
      File.new(file(relative_path).to_s, 'w')
    end

    def files
      @files.keys
    end

    def directories
      @directories ||= @files
        .keys
        .flat_map { |relative_path| Pathname.new(relative_path).ascend.to_a }
        .map(&:to_s)
        .uniq
    end

    def relative_path(absolute_path)
      Pathname.new(absolute_path).relative_path_from(@root).to_s
    end

    private

    def file(name)
      return @files[name] if @files[name]
      @files[name] = @root.join(name)
    end
  end
end
