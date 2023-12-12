namespace :i18n do
  task :json_to_js, [:json_file, :js_file] => :environment do |_, args|
    json_file_path = args.fetch(:json_file, Rails.root.join('app', 'javascript', 'translations.json'))
    js_file_path = args.fetch(:js_file, Rails.root.join('app', 'javascript', 'translations.js'))

    json_data = JSON.parse(File.read(json_file_path))
    js_code = "export default #{json_data.to_json};"

    File.open(js_file_path, 'w') do |file|
      file.write(js_code)
    end

    puts "JSON file converted to JS successfully!"
  end
end
