if [[ `uname` == "Darwin" ]]; then
  wget -qc https://x.brendan.so/thfst-tools_macos -O thfst-tools
else
  wget -qc https://x.brendan.so/thfst-tools_linux -O thfst-tools
fi

chmod +x ./thfst-tools
mkdir -p tmp-download
pushd tmp-download
echo sma
wget -qc -r -nd -np -A deb -e robots=off https://apertium.projectjj.com/apt/nightly/pool/main/g/giella-sma/
echo sme
wget -qc -r -nd -np -A deb -e robots=off https://apertium.projectjj.com/apt/nightly/pool/main/g/giella-sme/
echo smj
wget -qc -r -nd -np -A deb -e robots=off https://apertium.projectjj.com/apt/nightly/pool/main/g/giella-smj/
echo smn
wget -qc -r -nd -np -A deb -e robots=off https://apertium.projectjj.com/apt/nightly/pool/main/g/giella-smn/
echo sms
wget -qc -r -nd -np -A deb -e robots=off https://apertium.projectjj.com/apt/nightly/pool/main/g/giella-sms/
popd

for f in tmp-download/*.deb; do
  echo $f
  mkdir tmp
  cd tmp
  ar x ../$f
  tar xf data.tar.gz
  mv usr/share/giella/mobilespellers/* .
  fn=`ls *.zhfst`
  name=`basename "$fn" -mobile.zhfst`.zhfst
  mv *.zhfst ../$name
  cd ..
  rm -r tmp
done

rm -r tmp-download
ls *.zhfst

for f in *.zhfst; do
 ./thfst-tools zhfst-to-bhfst $f
 rm $f
done

ls *.bhfst
