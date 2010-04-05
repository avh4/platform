class Platform
  TEMPLATE_FOLDER = "lib"
  
  def self.process_document(input, output)
    require 'maruku'
    engine = Maruku.new(File.read(input))
    File.open(output, 'w') do |f|
      f.write(File.read("#{TEMPLATE_FOLDER}/header.txt"))
      f.write(engine.to_html)
      f.write(File.read("#{TEMPLATE_FOLDER}/footer.txt"))
    end
  end
end
