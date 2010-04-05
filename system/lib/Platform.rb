require 'maruku'

class Platform
  TEMPLATE_FOLDER = File.dirname(__FILE__)
  
  def self.process_documents
    puts "Platform: Processing documents in " + Dir.pwd
    Dir.entries(".").reject {|f| f !~ /\.markdown$/}.each do |f|
      Platform.process_document(f)
    end
  end
  
  def self.process_document(file)
    puts "Platform: Processing document " + file
    engine = Maruku.new(File.read(file))
    File.open("#{file}.html", 'w') do |f|
      f.write(File.read("#{TEMPLATE_FOLDER}/header.txt"))
      f.write(engine.to_html)
      f.write(File.read("#{TEMPLATE_FOLDER}/footer.txt"))
    end
  end
end
