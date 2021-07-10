
<table width="100%">
    <tr>
        <td width="33.33%" align="center">
            <div style="border:1px solid #ddd;box-sizing:border-box;width: 150px;height:150px;
background-image:url({{ asset('storage/'.LOGO_PATH.config('settings.logo')) }});
background-repeat:space;background-repeat: space;
background-size: 46px 30px;
background-origin: content-box;
padding: 25px;">
    <div style="width: 100px;height:100px;background:white;">
        {!! QrCode::size(100)->generate('Batch:1001;Code:WK5MMDKZ'); !!}
    </div>
</div>
        </td>
        <td width="33.33%" align="center">
            <div style="border:1px solid #ddd;box-sizing:border-box;width: 150px;height:150px;
            background-image:url({{ asset('storage/'.LOGO_PATH.config('settings.logo')) }});
            background-repeat:space;background-repeat: space;
            background-size: 46px 30px;
            background-origin: content-box;
            padding: 25px;">
                <div style="width: 100px;height:100px;background:white;">
                    {!! QrCode::size(100)->generate('Batch:1001;Code:80UT1NUK'); !!}
                </div>
            </div>
        </td>
        <td width="33.33%" align="center">

            <div style="border:1px solid #ddd;box-sizing:border-box;width: 150px;height:150px;
            background-image:url({{ asset('storage/'.LOGO_PATH.config('settings.logo')) }});
            background-repeat:space;background-repeat: space;
            background-size: 46px 30px;
            background-origin: content-box;
            padding: 25px;">
                <div style="width: 100px;height:100px;background:white;">
                    {!! QrCode::size(100)->generate('Batch:1002;Code:WK5MMDKZ'); !!}
                </div>
            </div>
        </td>
    </tr>
</table>

