#!/usr/bin/env bash

# Input nama mahasiswa
read -p "Nama mahasiswa: " nama

# Validasi nama
if [[ -z "$nama" ]]; then
    echo "Nama mahasiswa tidak boleh kosong."
    exit 1
fi

# Input nilai teori dan praktikum
read -p "Nilai teori [0-100]: " teori
read -p "Nilai praktikum [0-100]: " praktikum

# Validasi nilai teori
if ! [[ "$teori" =~ ^[0-9]+$ ]] || (( teori < 0 || teori > 100 )); then
    echo "Nilai teori harus berupa bilangan bulat 0-100."
    exit 1
fi

# Validasi nilai praktikum
if ! [[ "$praktikum" =~ ^[0-9]+$ ]] || (( praktikum < 0 || praktikum > 100 )); then
    echo "Nilai praktikum harus berupa bilangan bulat 0-100."
    exit 1
fi

# Menghitung nilai akhir
nilai_akhir=$(( (40 * teori + 60 * praktikum) / 100 ))

# Menentukan predikat
if (( nilai_akhir >= 85 )); then
    predikat="A"
    keterangan="Sangat baik"

elif (( nilai_akhir >= 75 )); then
    predikat="B"
    keterangan="Baik"

elif (( nilai_akhir >= 60 )); then
    predikat="C"
    keterangan="Cukup"

elif (( nilai_akhir >= 50 )); then
    predikat="D"
    keterangan="Perlu perbaikan"

else
    predikat="E"
    keterangan="Tidak lulus"
fi

# Menentukan status kelulusan
if (( nilai_akhir >= 60 && praktikum >= 50 )); then
    status="LULUS"

    # Nested conditional
    if (( praktikum >= 85 )); then
        catatan="Nilai praktikum sangat baik."
    else
        catatan="Nilai praktikum sudah memenuhi syarat."
    fi

else
    status="TIDAK LULUS"

    if (( praktikum < 50 )); then
        catatan="Nilai praktikum belum memenuhi syarat kelulusan."
    else
        catatan="Nilai akhir belum mencapai batas kelulusan."
    fi
fi

# Menentukan rekomendasi menggunakan case
case "$predikat" in
    A|B)
        rekomendasi="Pertahankan prestasi."
        ;;
    C)
        rekomendasi="Tingkatkan latihan dan pemahaman konsep."
        ;;
    D)
        rekomendasi="Ikuti remedial atau konsultasi dengan dosen."
        ;;
    E)
        rekomendasi="Ulangi materi dasar dan lakukan latihan tambahan."
        ;;
esac

# Menampilkan hasil penilaian
echo
echo "===== HASIL PENILAIAN ====="
echo "Nama          : $nama"
echo "Nilai teori   : $teori"
echo "Nilai praktik : $praktikum"
echo "Nilai akhir   : $nilai_akhir"
echo "Predikat      : $predikat"
echo "Keterangan    : $keterangan"
echo "Status        : $status"
echo "Rekomendasi   : $rekomendasi"
echo "Catatan       : $catatan"
echo "Dibuat pada   : $(date)"