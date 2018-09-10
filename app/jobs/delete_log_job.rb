class DeleteLogJob
  def perform
    if Rails.env == 'development'
      path = Rails.root.to_s + '/log/development.log'
    end
    if Rails.env == 'production'
      path = Rails.root.to_s + '/log/production.log'
    end

    crono = Rails.root.to_s + '/log/crono.log'

    file_path1 = File.join(path)
    file_path2 = File.join(crono)
    if File.exist?(file_path1)
      File.delete(file_path1)
    end
    if File.exist?(file_path2)
      File.delete(file_path2)
    end


  end
end
