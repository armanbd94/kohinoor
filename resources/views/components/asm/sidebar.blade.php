<div class="aside aside-left  aside-fixed  d-flex flex-column flex-row-auto" id="kt_aside">


    <div class="brand flex-column-auto " id="kt_brand">
        <div class="brand-logo">
            @if (config('settings.logo'))
            <a href="{{ url('/') }}">
                <img src="{{ asset('storage/'.LOGO_PATH.config('settings.logo'))}}" style="max-width: 100px;max-height:50px;" alt="Logo" />
            </a>
            @else
            <h3 class="text-white">{{ config('settings.title') ? config('settings.title') : env('APP_NAME') }}</h3>
            @endif
        </div>

        <button class="brand-toggle btn btn-sm px-0" id="kt_aside_toggle">
            <span class="svg-icon svg-icon-xl">
                <svg
                    xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                    width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                        <polygon points="0 0 24 0 24 24 0 24" />
                        <path
                            d="M5.29288961,6.70710318 C4.90236532,6.31657888 4.90236532,5.68341391 5.29288961,5.29288961 C5.68341391,4.90236532 6.31657888,4.90236532 6.70710318,5.29288961 L12.7071032,11.2928896 C13.0856821,11.6714686 13.0989277,12.281055 12.7371505,12.675721 L7.23715054,18.675721 C6.86395813,19.08284 6.23139076,19.1103429 5.82427177,18.7371505 C5.41715278,18.3639581 5.38964985,17.7313908 5.76284226,17.3242718 L10.6158586,12.0300721 L5.29288961,6.70710318 Z"
                            fill="#000000" fill-rule="nonzero"
                            transform="translate(8.999997, 11.999999) scale(-1, 1) translate(-8.999997, -11.999999) " />
                        <path
                            d="M10.7071009,15.7071068 C10.3165766,16.0976311 9.68341162,16.0976311 9.29288733,15.7071068 C8.90236304,15.3165825 8.90236304,14.6834175 9.29288733,14.2928932 L15.2928873,8.29289322 C15.6714663,7.91431428 16.2810527,7.90106866 16.6757187,8.26284586 L22.6757187,13.7628459 C23.0828377,14.1360383 23.1103407,14.7686056 22.7371482,15.1757246 C22.3639558,15.5828436 21.7313885,15.6103465 21.3242695,15.2371541 L16.0300699,10.3841378 L10.7071009,15.7071068 Z"
                            fill="#000000" fill-rule="nonzero" opacity="0.3"
                            transform="translate(15.999997, 11.999999) scale(-1, 1) rotate(-270.000000) translate(-15.999997, -11.999999) " />
                    </g>
                </svg>
            </span>
        </button>
    </div>


    <div class="aside-menu-wrapper flex-column-fluid" id="kt_aside_menu_wrapper">
        <div id="kt_aside_menu" class="aside-menu my-4 " data-menu-vertical="1" data-menu-scroll="1" data-menu-dropdown-timeout="500">
            <ul class="menu-nav ">

                <!-- Begin :: Dashboard -->
                <li class="menu-item {{ request()->is('asm/dashboard') ? 'menu-item-active' : '' }}" aria-haspopup="true">
                    <a href="{{ url('asm/dashboard') }}" class="menu-link">
                        <span class="svg-icon menu-icon"><i class="fas fa-tachometer-alt"></i></span>
                        <span class="menu-text">Dashboard</span>
                    </a>
                </li>
                <!-- End :: Dashboard -->

                <!-- Begin :: Sale -->
                <li class="menu-item menu-item-submenu {{ (request()->is('asm/sale/create')) ? 'menu-item-open' : '' }} {{ (request()->is('asm/sale')) ? 'menu-item-open' : '' }}" aria-haspopup="true" data-menu-toggle="hover">
                    <a href="javascript:void();" class="menu-link menu-toggle">
                        <span class="svg-icon menu-icon"><i class="fas fa-shopping-cart"></i></span>
                        <span class="menu-text">Sale</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="menu-submenu " style="" kt-hidden-height="80">
                        <span class="menu-arrow"></span>
                        <ul class="menu-subnav">
                            <li class="menu-item {{ (request()->is('asm/sale/create')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/sale/add') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Add Sale</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/sale')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/sale') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Manage Sale</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- End :: Sale -->

                <!-- Begin :: Coupon Received -->
                <li class="menu-item {{ request()->is('asm/coupon-received') ? 'menu-item-active' : '' }}" aria-haspopup="true">
                    <a href="{{ url('asm/coupon-received') }}" class="menu-link">
                        <span class="svg-icon menu-icon"><i class="fas fa-qrcode"></i></span>
                        <span class="menu-text">Coupon Received</span>
                    </a>
                </li>
                <!-- End :: Coupon Received -->

                <!-- Begin :: Inventory -->
                <li class="menu-item {{ request()->is('asm/inventory') ? 'menu-item-active' : '' }}" aria-haspopup="true">
                    <a href="{{ url('asm/inventory') }}" class="menu-link">
                        <span class="svg-icon menu-icon"><i class="fas fa-boxes"></i></span>
                        <span class="menu-text">Inventory</span>
                    </a>
                </li>
                 <!-- End :: Inventory --> 

                <!-- Begin :: Customer -->
                <li class="menu-item menu-item-submenu 
                {{ (request()->is('asm/customer')) ? 'menu-item-open' : '' }} 
                {{ (request()->is('asm/customer-ledger')) ? 'menu-item-open' : '' }}
                {{ (request()->is('asm/credit-customer')) ? 'menu-item-open' : '' }}
                {{ (request()->is('asm/paid-customer')) ? 'menu-item-open' : '' }}
                {{ (request()->is('asm/customer-advance')) ? 'menu-item-open' : '' }}
                " aria-haspopup="true" data-menu-toggle="hover">
                    <a href="javascript:void();" class="menu-link menu-toggle">
                        <span class="svg-icon menu-icon"><i class="far fa-handshake"></i></span>
                        <span class="menu-text">Customer</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="menu-submenu " style="" kt-hidden-height="80">
                        <span class="menu-arrow"></span>
                        <ul class="menu-subnav">
                            <li class="menu-item {{ (request()->is('asm/customer')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/customer') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Manage Customer</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/customer-ledger')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/customer-ledger') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Customer Ledger</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/credit-customer')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/credit-customer') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Credit Customer</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/paid-customer')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/paid-customer') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Paid Customer</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/customer-advance')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/customer-advance') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Customer Advance</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- End :: Customer -->

                <!-- Begin :: Report -->
                <li class="menu-item menu-item-submenu 
                    {{ (request()->is('asm/closing')) ? 'menu-item-open' : '' }} 
                    {{ (request()->is('asm/closing-report')) ? 'menu-item-open' : '' }} 
                    {{ (request()->is('asm/todays-sales-report')) ? 'menu-item-open' : '' }}
                    {{ (request()->is('asm/todays-customer-receipt')) ? 'menu-item-open' : '' }}
                    {{ (request()->is('asm/salesmen-wise-sales-report')) ? 'menu-item-open' : '' }}
                    {{ (request()->is('asm/due-report')) ? 'menu-item-open' : '' }}
                    {{ (request()->is('asm/shipping-cost-report')) ? 'menu-item-open' : '' }}
                    {{ (request()->is('asm/product-wise-sales-report')) ? 'menu-item-open' : '' }}
                    " aria-haspopup="true" data-menu-toggle="hover">
                    <a href="javascript:void();" class="menu-link menu-toggle">
                        <span class="svg-icon menu-icon"><i class="fas fa-file-signature"></i></span>
                        <span class="menu-text">Report</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="menu-submenu " style="" kt-hidden-height="80">
                        <span class="menu-arrow"></span>
                        <ul class="menu-subnav">
                            <li class="menu-item {{ (request()->is('asm/closing')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/closing') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Closing</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/closing-report')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/closing-report') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Closing Report</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/todays-sales-report')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/todays-sales-report') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Todays Sales Report</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/todays-customer-receipt')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/todays-customer-receipt') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Todays Customer Receipt</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/salesmen-wise-sales-report')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/salesmen-wise-sales-report') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Salesmen Wise Sales Report</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/due-report')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/due-report') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Due Report</span>
                                </a>
                            </li>

                            <li class="menu-item {{ (request()->is('asm/shipping-cost-report')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/shipping-cost-report') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Shipping Cost Report</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/product-wise-sales-report')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/product-wise-sales-report') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Product Wise Sales Report</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- End :: Report -->

                <!-- Begin :: Report -->
                <li class="menu-item menu-item-submenu 
                    {{ (request()->is('asm/opening-balance')) ? 'menu-item-open' : '' }} 
                    {{ (request()->is('asm/customer-receive')) ? 'menu-item-open' : '' }}" aria-haspopup="true" data-menu-toggle="hover">
                    <a href="javascript:void();" class="menu-link menu-toggle">
                        <span class="svg-icon menu-icon"><i class="far fa-money-bill-alt"></i></span>
                        <span class="menu-text">Accounts</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="menu-submenu " style="" kt-hidden-height="80">
                        <span class="menu-arrow"></span>
                        <ul class="menu-subnav">
                            <li class="menu-item {{ (request()->is('asm/opening-balance')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/opening-balance') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Opening Balance</span>
                                </a>
                            </li>
                            <li class="menu-item {{ (request()->is('asm/customer-receive')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/customer-receive') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Customer Receive</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- End :: Report -->

                <!-- Begin :: Sales Reprensentative -->
                <li class="menu-item {{ (request()->is('asm/sales-representative')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                    <a href="{{ url('asm/sales-representative') }}" class="menu-link">
                        <span class="svg-icon menu-icon"><i class="fas fa-user-secret"></i></span>
                        <span class="menu-text">Sales Representative</span>
                    </a>
                </li>
                <!-- End :: Sales Reprensentative -->

                <!-- Begin :: Location -->
                <li class="menu-item menu-item-submenu   {{ (request()->is('asm/upazila')) ? 'menu-item-open' : '' }} {{ (request()->is('asm/route')) ? 'menu-item-open' : '' }}" aria-haspopup="true" data-menu-toggle="hover">
                    <a href="javascript:void();" class="menu-link menu-toggle">
                        <span class="svg-icon menu-icon"><i class="fas fa-map-marker-alt"></i></span>
                        <span class="menu-text">Location</span>
                        <i class="menu-arrow"></i>
                    </a>
                    <div class="menu-submenu" style="" kt-hidden-height="120">
                        <span class="menu-arrow"></span>
                        <ul class="menu-subnav">
                            <li class="menu-item  {{ (request()->is('asm/upazila')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/upazila') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Upazila</span>
                                </a>
                            </li>
                            <li class="menu-item  {{ (request()->is('asm/route')) ? 'menu-item-active' : '' }}" aria-haspopup="true">
                                <a href="{{ url('asm/route') }}" class="menu-link ">
                                    <i class="menu-bullet menu-bullet-dot"><span></span></i>
                                    <span class="menu-text">Route</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- End :: Location -->
            </ul>
        </div>
    </div>
</div>