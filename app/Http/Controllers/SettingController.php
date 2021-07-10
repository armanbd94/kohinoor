<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use App\Traits\UploadAble;
use App\Http\Controllers\BaseController;
use App\Http\Requests\SettingFormRequest;
use App\Http\Requests\SMTPSettingFormRequest;

class SettingController extends BaseController

{
    use UploadAble;
    public function __construct(Setting $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if (permission('setting-access')) {
            $zones_array = array();
            $timestamp = time();
            foreach(timezone_identifiers_list() as $key => $zone) {
                date_default_timezone_set($zone);
                $zones_array[$key]['zone'] = $zone;
                $zones_array[$key]['diff_from_GMT'] = 'UTC/GMT ' . date('P', $timestamp);
            }
            $this->setPageData('Setting','Setting','fas fa-cogs',[['name' => 'Setting']]);
            return view('settings.index',compact('zones_array'));
        }else{
            return $this->access_blocked();
        }

        
    }

    public function general_setting(SettingFormRequest $request)
    {
        if($request->ajax()){
            if (permission('setting-access')) {
                $collection       = collect($request->validated())->except(['logo','favicon']);
                foreach ($collection->all() as $key => $value)
                {
                    Setting::set($key, $value);
                    if($key == 'timezone'){
                        if (!empty($value)) {
                            $this->changeEnvData(['APP_TIMEZONE'    => $value ]);
                        }
                    }
                }

                if($request->hasFile('logo')){
                    $logo    = $this->upload_file($request->file('logo'),LOGO_PATH);
                    if(!empty($request->old_logo)){
                        $this->delete_file($request->old_logo, LOGO_PATH);
                    }
                    Setting::set('logo', $logo);
                }

                if($request->hasFile('favicon')){
                    $favicon    = $this->upload_file($request->file('favicon'),LOGO_PATH);
                    if(!empty($request->old_favicon)){
                        $this->delete_file($request->old_favicon, LOGO_PATH);
                    }
                    Setting::set('favicon', $favicon);
                }

                $output       = ['status' => 'success','message' => 'Data has beed saved successfully'];
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);    
            
        }
    }

    public function mail_setting(SMTPSettingFormRequest $request)
    {
        if ($request->ajax()) {
            if (permission('setting-access')) {
                
                $collection       = collect($request->validated());
                foreach ($collection->all() as $key => $value)
                {
                    Setting::set($key, $value);
                }

                $this->changeEnvData([
                    'MAIL_MAILER'     => $request->mail_mailer,
                    'MAIL_HOST'       => $request->mail_host,
                    'MAIL_PORT'       => $request->mail_port,
                    'MAIL_USERNAME'   => $request->mail_username,
                    'MAIL_PASSWORD'   => $request->mail_password,
                    'MAIL_ENCRYPTION' => $request->mail_encryption,
                    'MAIL_FROM_NAME'  => $request->mail_from_name,
                ]);
                $output       = ['status' => 'success','message' => 'Data has beed saved successfully'];
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);   
        }

    }

    private function changeEnvData($data = array())
    {
        if (!count($data)) {
            return;
        }
    
        $pattern = '/([^\=]*)\=[^\n]*/';
    
        $envFile = base_path() . '/.env';
        $lines = file($envFile);
        $newLines = [];
        foreach ($lines as $line) {
            preg_match($pattern, $line, $matches);
    
            if (!count($matches)) {
                $newLines[] = $line;
                continue;
            }
    
            if (!key_exists(trim($matches[1]), $data)) {
                $newLines[] = $line;
                continue;
            }
            if($matches[1] == 'MAIL_FROM_NAME'){
                $line = trim($matches[1]) . "='{$data[trim($matches[1])]}'\n";
            }else{
                $line = trim($matches[1]) . "={$data[trim($matches[1])]}\n";
            }
            
       
            $newLines[] = $line;
        }
        
        $newContent = implode('', $newLines);
        file_put_contents($envFile, $newContent);
    }

    // protected function changeEnvData(array $data){
    //     if(count($data) > 0){

    //         // Read .env-file
    //         $env = file_get_contents(base_path() . '/.env');

    //         // Split string on every " " and write into array
    //         $env = preg_split('/\s+/', $env);;

    //         // Loop through given data
    //         foreach((array)$data as $key => $value){

    //             // Loop through .env-data
    //             foreach($env as $env_key => $env_value){

    //                 // Turn the value into an array and stop after the first split
    //                 // So it's not possible to split e.g. the App-Key by accident
    //                 $entry = explode("=", $env_value, 2);

    //                 // Check, if new key fits the actual .env-key

    //                 if($entry[0] == $key){
    //                     // If yes, overwrite it with the new one
    //                     if($key == 'APP_NAME' || $key == 'MAIL_FROM_NAME'){
    //                         $env[$env_key] = $key . "='" . $value."'";
    //                     }else{
    //                         $env[$env_key] = $key . "=" . $value;
    //                     }
                        
    //                     // echo "$env[$env_key] ====== $key . '=' . ".str_word_count($value)."  -> $value<br><br>";
    //                 } else {
    //                     // If not, keep the old one
    //                     // $env[$env_key] = $env_value;
    //                     $envValue = explode('=',$env_value,2);
    //                     echo '<pre>';
    //                     print_r($envValue);
    //                     if($envValue[0] == 'APP_NAME' || $envValue[0] == 'MAIL_FROM_NAME'){
    //                         // echo $env_key.' == '.$envValue[1].'<br>';
    //                         // $env[$env_key] = $envValue[0] . "='" . $envValue[1] ? $envValue[1] : ''."'";
    //                     }else{
    //                         // echo $env_key.' == '.$envValue[1].'<br>';
    //                         // $env[$env_key] = $envValue[0] . "=" . $envValue[1] ?  $envValue[1] : '';
    //                     }
    //                     // echo "$env[$env_key] = ".str_word_count($env_value)." ========= $env_value<br><br>";
    //                 }
    //             }
                
    //         }
    //         // dd($env);
    //         exit;
    //         // Turn the array back to an String
    //         $env = implode("\n", $env);

    //         // And overwrite the .env with the new data
    //         file_put_contents(base_path() . '/.env', $env);
            
    //         return true;
    //     } else {
    //         return false;
    //     }
    // }
}
