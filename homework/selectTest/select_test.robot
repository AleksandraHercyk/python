*** Settings ***
Documentation    Suite description

Resource    ../base/resource.robot
*** Test Cases ***
Select test
    [Tags]    DEBUG
    Open Browser To Login Page
    Input Username      standard_user
    Input Password      secret_sauce
    Click Button        name=login-button
    Select From List by Value   class=product_sort_container        hilo
    Click Button        Add to cart
    Click Button        Add to cart
    Click Button        Add to cart
    Click Link          class=shopping_cart_link
    ${name0}=           Get Text      xpath=//*[@class="cart_list"]//div[@class="cart_item"][1]//div[@class="cart_item_label"]//div[@class="inventory_item_name"]
    ${name1}=           Get Text      xpath=//*[@class="cart_list"]//div[@class="cart_item"][2]//div[@class="cart_item_label"]//div[@class="inventory_item_name"]
    ${name2}=           Get Text      xpath=//*[@class="cart_list"]//div[@class="cart_item"][3]//div[@class="cart_item_label"]//div[@class="inventory_item_name"]
    ${quantity0}=       Get Text      xpath=//*[@class="cart_list"]//div[@class="cart_item"][1]//div[@class="cart_quantity"]
    ${quantity1}=       Get Text      xpath=//*[@class="cart_list"]//div[@class="cart_item"][2]//div[@class="cart_quantity"]
    ${quantity2}=       Get Text      xpath=//*[@class="cart_list"]//div[@class="cart_item"][3]//div[@class="cart_quantity"]
    ${value0}=          Get Text      xpath=//*[@class="cart_list"]//div[@class="cart_item"][1]//div[@class="cart_item_label"]//div[@class="item_pricebar"]//div[@class="inventory_item_price"]
    ${value1}=          Get Text      xpath=//*[@class="cart_list"]//div[@class="cart_item"][2]//div[@class="cart_item_label"]//div[@class="item_pricebar"]//div[@class="inventory_item_price"]
    ${value2}=          Get Text      xpath=//*[@class="cart_list"]//div[@class="cart_item"][3]//div[@class="cart_item_label"]//div[@class="item_pricebar"]//div[@class="inventory_item_price"]
    Log To Console      Item: ${name0}, Quantity: ${quantity0}, Price: ${value0[1:]}$
    Log To Console      Item: ${name1}, Quantity: ${quantity1}, Price: ${value1[1:]}$
    Log To Console      Item: ${name2}, Quantity: ${quantity2}, Price: ${value2[1:]}$
    Click Button        checkout
    Input First Name    XYZ
    Input Last Name     ABC
    Input Zip Code      77-777
    Click Button        continue
    ${item_total}=      Get Text      xpath=//*[@class="summary_subtotal_label"]
    ${tax}=             Get Text      xpath=//*[@class="summary_tax_label"]
    ${total}=           Get Text      xpath=//*[@class="summary_total_label"]
    ${item_total}=      Convert To Number   ${item_total[-5:]}
    ${tax}=             Convert To Number   ${tax[-4:]}
    ${total}=           Convert To Number   ${total[-6:]}
    ${calculated_tax}=  Evaluate    ${total} - ${item_total}
    ${calculated_tax}=  Convert To Number   ${calculated_tax}   2
    Log To Console      ${total} ${item_total} ${tax} ${calculated_tax}
    Should Be Equal     ${calculated_tax}      ${tax}
    [Teardown]          Close Browser

