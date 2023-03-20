#!/bin/bash

DIR=`dirname $0`

ARCH=rv32gcv
ABI=ilp32d

GCC_DIR="/share/rd/toolchain/gnu-riscv-elf-rvv-next"

SPIKE="spike --isa=rv32gcv --varch=vlen:512,elen:32 ${GCC_DIR}/riscv32-unknown-elf/bin/pk "
QEMU="qemu-riscv32 -cpu rv32,v=true,vext_spec=v1.0,vlen=512,elen=32 "
ZEMU="zemu --vlen=512 --march=${ARCH}"

CC="riscv64-unknown-elf-gcc -march=${ARCH} -mabi=${ABI} -O3 -I ${DIR}/include -DNDEBUG"
AR="riscv64-unknown-elf-ar"

GCC="riscv64-unknown-elf-gcc -march=${ARCH} -mabi=${ABI} -O3 -I ${DIR}/include "
ZCC="zcc -fno-lto --target=riscv32-unknown-elf -march=${ARCH} -mabi=${ABI} -O3 -I ${DIR}/include "
ZCC+="-mllvm -no-integer-promotions "
CLANG="clang -fno-lto --target=riscv32-unknown-elf "
CLANG+="-march=${ARCH} -mabi=${ABI} -O3 -I ${DIR}/include -I ${GCC_DIR}/riscv64-unknown-elf/include"

build_and_run() {
  case $1 in
    intrinsic_dji)
      COMPILER=${ZCC}
      BUILD_DIR=${DIR}/build/intrinsic_dji
      ;;
    intrinsic_inner)
      COMPILER=${ZCC}
      BUILD_DIR=${DIR}/build/intrinsic_inner
      ;;
    zcc_auto_inner)
      COMPILER=${ZCC}
      BUILD_DIR=${DIR}/build/zcc_auto_inner
      ;;
    zcc_auto_outer)
      COMPILER="${ZCC} -mllvm -enable-vplan-native-path "
      BUILD_DIR=${DIR}/build/zcc_auto_outer
      ;;
    gcc)
      COMPILER=${GCC}
      BUILD_DIR=${DIR}/build/gcc
      ;;
    clang)
      COMPILER=${CLANG}
      BUILD_DIR=${DIR}/build/clang
      ;;
    ?*)
      echo "Unknwon option"
      exit -1
      ;;
  esac
  rm -rf ${BUILD_DIR}
  mkdir -p ${BUILD_DIR}/obj
  mkdir -p ${BUILD_DIR}/lib
  mkdir -p ${BUILD_DIR}/bin
  for kernel in ${DIR}/${2}/*.c; do
    name=`basename ${kernel} .c`
    ${COMPILER} -c ${kernel} -o ${BUILD_DIR}/obj/${name}.o
  done

  find ${BUILD_DIR}/obj -name "*.o" | xargs ${AR} rcs ${BUILD_DIR}/lib/libkernel.a
  
  for main in ${DIR}/main/*.c; do
    name=`basename ${main} .c`
    ${CC} ${main} -L ${BUILD_DIR}/lib -lkernel -o ${BUILD_DIR}/bin/${name}
    ${ZEMU} ${BUILD_DIR}/bin/${name} > ${BUILD_DIR}/bin/${name}.log &
  done
}

echo "build intrinsic_dji using zcc"
build_and_run intrinsic_dji intrinsic_dji
echo "build intrinsic_inner using zcc"
build_and_run intrinsic_inner intrinsic_inner
echo "build golden using zcc"
build_and_run zcc_auto_inner golden
echo "build golden using zcc with outer loop vectorization"
build_and_run zcc_auto_outer golden
echo "build golden using gcc"
build_and_run gcc golden
echo "build golden using clang"
build_and_run clang golden

TMP=$(ps aux | grep zemu | wc -l)
echo "waiting for zemu to finish..."
while [ "x$TMP" != "x1" ]
do
  TMP=$(ps aux | grep zemu | wc -l)
  sleep 3
done
echo "zemu finished."

echo "Report performace to ${DIR}/build/report.xls"

arr=(intrinsic_dji zcc_auto_outer intrinsic_inner zcc_auto_inner gcc clang)
echo -e "\tintrinsic_dji(zcc)\tzcc(auto outer)\tintrinsic_inner(zcc)\tzcc\tgcc\tclang" \
> ${DIR}/build/report.xls
for kernel in correlation psroi resize warp; do
  echo -ne "${kernel}" >> ${DIR}/build/report.xls
  for tmp in ${arr[@]}; do
    cat ${DIR}/build/${tmp}/bin/${kernel}.log | awk '{printf "\t"$NF}' >> ${DIR}/build/report.xls
  done
  echo "" >> ${DIR}/build/report.xls
done

echo "" >> ${DIR}/build/report.xls
echo "" >> ${DIR}/build/report.xls
echo "${ZCC} (-mllvm -enable-vplan-native-path)" >> ${DIR}/build/report.xls
${ZCC} --version >> ${DIR}/build/report.xls
echo "" >> ${DIR}/build/report.xls

echo "${GCC}" >> ${DIR}/build/report.xls
${GCC} --version >> ${DIR}/build/report.xls

echo "${CLANG}" >> ${DIR}/build/report.xls
${CLANG} --version >> ${DIR}/build/report.xls
