DirName1=rootdir
DirName2=subdir
FileName=testf

# 200,000 files, 200GB
#DirCt=200
#FileCt=1000
#FileSize=1000

# 10,000,000 files (10K), 1000GB
#DirCt=200
#FileCt=1000
#FileSize=10
#


# 6,000,000 files, 1.8 TB
RootDirCt=2
DirCt=3
FileCt=3
FileSize=100


for((r=1;r<=$RootDirCt;r++));do
  mkdir $DirName1$r 1>/dev/null 2>/dev/null
  echo "Creating Root-DIR "$r""
  cd $DirName1$r 1>/dev/null 2>/dev/null

  for((i=1;i<=$DirCt;i++));do
    mkdir $DirName2$i 1>/dev/null 2>/dev/null
    echo "Creating Sub-DIR "$i""
    #cd $DirName$i 1>/dev/null 2>/dev/null

    for((k=1;k<=5;k++));do
      cd $DirName2$i 1>/dev/null 2>/dev/null
      if [ $? == 0 ]; then
        for((j=1;j<=$FileCt;j++));do
          echo "Creating DIR"$i"-File"$j""
          dd if=/dev/zero of=$FileName$j bs=1k count=$FileSize 1>/dev/null 2>/dev/null
        done
        cd ..
        break
      else
        sync
      fi
    done
  done
  cd ..
done

