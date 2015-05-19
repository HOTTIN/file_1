# encoding: sjis

MYOBJ = ARGV[0]




#変換前ソース
OLD_DATA="D:\\p4-workspace\\PT-E550WTW_HK\\simulation\\Sim"
#変換後ソース
NEW_DATA="D:\\SVN-Workspace\\E550WTWHK_Merge\\simulation\\Sim"
#出力フォルダ
DATAROOT="D:\\minework\\E550WTWHKSimresult"









#load 'ZipFileUtils.rb'
OLD_LIST="変更前.txt"
NEW_LIST="変更後.txt"
OLD_FOLD="変更前"
NEW_FOLD="変更後"

require "fileutils"
def eazy_fold(foldName)
	begin
		FileUtils.mkdir_p(foldName)
	rescue
	end
end


def exceptStringFunc(str)
	ret=false
	exceptionStr=[".","..",".svn","Debug","Release"]
	exceptionStr.each do |expStr|
		if(str == expStr)
			ret=true
		end
	end
	return ret
end

def old_dir(file_path,f)
	Dir.foreach(file_path) do |file|
		fullPath = file_path+"\\"+ file
		if exceptStringFunc(file)
		elsif File.directory?(fullPath)
			resPath = fullPath.gsub(OLD_DATA, DATAROOT + "\\" + OLD_FOLD)
			old_dir(fullPath,f)
		else
			f.puts fullPath
			newFullPath = fullPath.gsub(OLD_DATA, NEW_DATA)
			begin
				begin
					if(FileUtils.cmp( fullPath, newFullPath ))
					else
						oldFilePath = fullPath.gsub(OLD_DATA, DATAROOT + "\\" + OLD_FOLD)
						oldFoldPath = oldFilePath.gsub("\\" + File.basename(oldFilePath),"")
						eazy_fold(oldFoldPath)
						FileUtils.cp( fullPath, oldFoldPath)
						
						newFilePath = newFullPath.gsub(NEW_DATA, DATAROOT + "\\" + NEW_FOLD)
						newFoldPath = newFilePath.gsub("\\" + File.basename(newFilePath),"")
						eazy_fold(newFoldPath)
						FileUtils.cp( newFullPath, newFoldPath)
						
					end
				rescue
						oldFilePath = fullPath.gsub(OLD_DATA, DATAROOT + "\\" + OLD_FOLD)
						oldFoldPath = oldFilePath.gsub("\\" + File.basename(oldFilePath),"")
						eazy_fold(oldFoldPath)
						FileUtils.cp( fullPath, oldFoldPath)
						
						newFilePath = newFullPath.gsub(NEW_DATA, DATAROOT + "\\" + NEW_FOLD)
						newFoldPath = newFilePath.gsub("\\" + File.basename(newFilePath),"")
						eazy_fold(newFoldPath)
						FileUtils.cp( newFullPath, newFoldPath)
				end
			rescue
			end
		end
	end
end

def new_dir(file_path,f)
	Dir.foreach(file_path) do |file|
		fullPath = file_path+"\\"+ file
		if exceptStringFunc(file)
		elsif File.directory?(fullPath)
			resPath = fullPath.gsub(NEW_DATA, DATAROOT + "\\" + NEW_FOLD)
			new_dir(fullPath,f)
		else
			f.puts fullPath
			oldFullPath = fullPath.gsub(NEW_DATA, OLD_DATA)
			begin
				begin
					if(FileUtils.cmp( fullPath, oldFullPath ))
					else
						newFilePath = fullPath.gsub(NEW_DATA, DATAROOT + "\\" + NEW_FOLD)
						newFoldPath = newFilePath.gsub("\\" + File.basename(newFilePath),"")
						eazy_fold(newFoldPath)
						FileUtils.cp( fullPath, newFoldPath)
						
						oldFilePath = oldFullPath.gsub(NEW_DATA, DATAROOT + "\\" + NEW_FOLD)
						oldFoldPath = oldFilePath.gsub("\\" + File.basename(oldFilePath),"")
						eazy_fold(oldFoldPath)
						FileUtils.cp( oldFullPath, oldFoldPath)
					end
				rescue
						newFilePath = fullPath.gsub(NEW_DATA, DATAROOT + "\\" + NEW_FOLD)
						newFoldPath = newFilePath.gsub("\\" + File.basename(newFilePath),"")
						eazy_fold(newFoldPath)
						FileUtils.cp( fullPath, newFoldPath)
						
						oldFilePath = oldFullPath.gsub(NEW_DATA, DATAROOT + "\\" + NEW_FOLD)
						oldFoldPath = oldFilePath.gsub("\\" + File.basename(oldFilePath),"")
						eazy_fold(oldFoldPath)
						FileUtils.cp( oldFullPath, oldFoldPath)
				end
			rescue
			end
		end
	end
end
# フォルダ削除
if(File.exist?(DATAROOT))
	system "rd /s /q " + DATAROOT
end
eazy_fold(DATAROOT)
Dir.chdir(DATAROOT)
eazy_fold(OLD_FOLD)
eazy_fold(NEW_FOLD)
f = open(OLD_LIST,"w+")
old_dir(OLD_DATA,f)
f.close
f = open(NEW_LIST,"w+")
new_dir(NEW_DATA,f)
f.close

# HTML結果ファイルを圧縮
#ZipFileUtils.zip(DATAROOT,DATAROOT+ "\\" +"result.zip")
