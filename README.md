PHIEUXUAT(
    SoPX PK,
    NgayXuat
)

VATTU(
    MaVTU PK,
    TenVTU
)

PHIEUNHAP(
    SoPN PK,
    NgayNhap
)

NHACC(
    MaNCC PK,
    TenNCC,
    DiaChi
)

DONDH(
    SoDH PK,
    NgayDH,
    MaNCC FK → NHACC(MaNCC)
)

NHACC_SDT(
    MaNCC PK, FK → NHACC(MaNCC),
    SDT PK
)

CT_PHIEUXUAT(
    SoPX PK, FK → PHIEUXUAT(SoPX),
    MaVTU PK, FK → VATTU(MaVTU),
    DGXuat,
    SLXuat
)

CT_PHIEUNHAP(
    SoPN PK, FK → PHIEUNHAP(SoPN),
    MaVTU PK, FK → VATTU(MaVTU),
    DGNhap,
    SLNhap
)

CT_DONDH(
    SoDH PK, FK → DONDH(SoDH),
    MaVTU PK, FK → VATTU(MaVTU)
)
