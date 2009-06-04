namespace :wurfl do
  desc "Download the latest wurfl.xml.gz, unpack it, and update the PStore."
  task :update do
    FileUtils.mkdir_p('tmp/wurfl')
    return_code = `cd tmp/wurfl/ && wget -N -- http://voxel.dl.sourceforge.net/sourceforge/wurfl/wurfl-latest.xml.gz`.to_i
    unless return_code == 0
      raise 'Failed to download wurfl-latest.xml.gz'
    end

    return_code = `cd tmp/wurfl/ && gunzip -c wurfl-latest.xml.gz > wurfl.xml`.to_i
    unless return_code == 0
      raise 'Failed to unzip wurfl-latest.xml.gz'
    end

    return_code = `cd lib && ruby wurfl/wurflloader.rb -d wurfl/wurfl_pstore -f wurfl/wurfl.xml`
  end
end