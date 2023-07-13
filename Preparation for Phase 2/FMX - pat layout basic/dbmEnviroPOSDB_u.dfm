object dmDatabase: TdmDatabase
  Height = 600
  Width = 694
  object conEnviroPosDB: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\joelc\Docu' +
      'ments\GitHub\itpat-2023\Preparation for Phase 2\FMX - authentica' +
      'tion\Win32\Debug\PAT_DB.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 544
    Top = 280
  end
  object tblCredentials: TADOTable
    Active = True
    Connection = conEnviroPosDB
    CursorType = ctStatic
    TableName = 'tblCredentials'
    Left = 136
    Top = 80
  end
  object dscCredentials: TDataSource
    DataSet = tblCredentials
    Left = 272
    Top = 80
  end
  object tblEmployees: TADOTable
    Active = True
    Connection = conEnviroPosDB
    CursorType = ctStatic
    TableName = 'tblEmployees'
    Left = 136
    Top = 192
  end
  object dscEmployees: TDataSource
    DataSet = tblEmployees
    Left = 280
    Top = 192
  end
  object tblOrders: TADOTable
    Active = True
    Connection = conEnviroPosDB
    CursorType = ctStatic
    TableName = 'tblOrders'
    Left = 136
    Top = 296
  end
  object tblOrderDetails: TADOTable
    Active = True
    Connection = conEnviroPosDB
    CursorType = ctStatic
    TableName = 'tblOrderDetails'
    Left = 136
    Top = 392
  end
  object tblCustomers: TADOTable
    Active = True
    Connection = conEnviroPosDB
    CursorType = ctStatic
    TableName = 'tblCustomers'
    Left = 136
    Top = 496
  end
  object tblInventory: TADOTable
    Active = True
    Connection = conEnviroPosDB
    CursorType = ctStatic
    TableName = 'tblInventory'
    Left = 136
    Top = 8
  end
  object dscOrders: TDataSource
    DataSet = tblOrders
    Left = 280
    Top = 296
  end
  object dscOrderDetails: TDataSource
    DataSet = tblOrderDetails
    Left = 280
    Top = 400
  end
  object dscCustomers: TDataSource
    DataSet = tblCustomers
    Left = 280
    Top = 504
  end
  object dscInventory: TDataSource
    DataSet = tblInventory
    Left = 272
    Top = 8
  end
  object SVGIconImageList1: TSVGIconImageList
    Source = <
      item
        MultiResBitmap = <
          item
            Size = 48
          end>
        IconName = 'storefront_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M42 22.05V39q0 1.2-.9 2.1-.9.9-2.1.9H8.95q-1.2 0-2.1-.9-' +
          '.9-.9-.9-2.1V22.05q-1.4-1.2-1.85-2.95-.45-1.75.1-3.5l2.15-6.75q.' +
          '4-1.35 1.4-2.1 1-.75 2.3-.75H37.7q1.4 0 2.45.775 1.05.775 1.45 2' +
          '.075l2.2 6.75q.55 1.75.075 3.5Q43.4 20.85 42 22.05ZM28.5 20.5q1.' +
          '45 0 2.45-.95 1-.95.8-2.3L30.5 9h-5v8.25q0 1.3.85 2.275.85.975 2' +
          '.15.975Zm-9.35 0q1.4 0 2.375-.95.975-.95.975-2.3V9h-5l-1.25 8.25' +
          'q-.2 1.3.7 2.275.9.975 2.2.975Zm-9.1 0q1.2 0 2.075-.825.875-.825' +
          ' 1.025-2.025L14.45 9h-5l-2.3 7.3q-.5 1.55.4 2.875t2.5 1.325Zm27.' +
          '85 0q1.6 0 2.525-1.3.925-1.3.425-2.9L38.55 9h-5l1.3 8.65q.15 1.2' +
          ' 1.025 2.025.875.825 2.025.825ZM8.95 39H39V23.45q.05.05-.325.05H' +
          '37.9q-1.25 0-2.375-.525T33.3 21.35q-.8 1-2 1.575t-2.65.575q-1.5 ' +
          '0-2.575-.425Q25 22.65 24 21.65q-.75.9-1.9 1.375t-2.6.475q-1.55 0' +
          '-2.75-.55t-2.05-1.6q-1.2 1.05-2.35 1.6-1.15.55-2.3.55h-.675q-.32' +
          '5 0-.425-.05V39ZM39 39H8.95 39Z"/></svg>'
        FixedColor = xFFFBFBFB
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 48
          end>
        IconName = 'groups_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M0 36v-2.65q0-1.95 2.1-3.15T7.5 29q.65 0 1.2.025.55.025 ' +
          '1.1.125-.4.85-.6 1.725-.2.875-.2 1.875V36Zm12 0v-3.25q0-3.25 3.3' +
          '25-5.25t8.675-2q5.4 0 8.7 2 3.3 2 3.3 5.25V36Zm27 0v-3.25q0-1-.1' +
          '75-1.875t-.575-1.725q.55-.1 1.1-.125Q39.9 29 40.5 29q3.4 0 5.45 ' +
          '1.2Q48 31.4 48 33.35V36Zm-15-7.5q-4 0-6.5 1.2T15 32.75V33h18v-.3' +
          'q0-1.8-2.475-3T24 28.5Zm-16.5-1q-1.45 0-2.475-1.025Q4 25.45 4 24' +
          'q0-1.45 1.025-2.475Q6.05 20.5 7.5 20.5q1.45 0 2.475 1.025Q11 22.' +
          '55 11 24q0 1.45-1.025 2.475Q8.95 27.5 7.5 27.5Zm33 0q-1.45 0-2.4' +
          '75-1.025Q37 25.45 37 24q0-1.45 1.025-2.475Q39.05 20.5 40.5 20.5q' +
          '1.45 0 2.475 1.025Q44 22.55 44 24q0 1.45-1.025 2.475Q41.95 27.5 ' +
          '40.5 27.5ZM24 24q-2.5 0-4.25-1.75T18 18q0-2.55 1.75-4.275Q21.5 1' +
          '2 24 12q2.55 0 4.275 1.725Q30 15.45 30 18q0 2.5-1.725 4.25T24 24' +
          'Zm0-9q-1.25 0-2.125.85T21 18q0 1.25.875 2.125T24 21q1.3 0 2.15-.' +
          '875Q27 19.25 27 18q0-1.3-.85-2.15Q25.3 15 24 15Zm0 18Zm0-15Z"/><' +
          '/svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
          end>
        IconName = 'finance_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" viewBox="0 -' +
          '960 960 960" width="48"><path d="M180-120q-24 0-42-18t-18-42v-66' +
          '0h60v660h660v60H180Zm75-135v-334h119v334H255Zm198 0v-540h119v540' +
          'H453Zm194 0v-170h119v170H647Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
          end>
        IconName = 'chart_data_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="m14.8 31.3 6.1-6.1 4 4 7.6-7.55v3.85h3v-9h-9v3h3.85l-5.4' +
          '5 5.45-4-4-8.2 8.25ZM9 42q-1.2 0-2.1-.9Q6 40.2 6 39V9q0-1.2.9-2.' +
          '1Q7.8 6 9 6h30q1.2 0 2.1.9.9.9.9 2.1v30q0 1.2-.9 2.1-.9.9-2.1.9Z' +
          'm0-3h30V9H9v30ZM9 9v30V9Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 48
          end>
        IconName = 'help_wght300grad200fill1_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M24.2 35.55q.75 0 1.3-.55t.55-1.35q0-.75-.55-1.3t-1.3-.5' +
          '5q-.75 0-1.3.55t-.55 1.3q0 .8.55 1.35t1.3.55Zm-1.7-7.25h2.9q0-1.' +
          '35.35-2.4.35-1.05 2-2.45 1.45-1.25 2.125-2.475t.675-2.725q0-2.65' +
          '-1.75-4.225-1.75-1.575-4.5-1.575-2.5 0-4.3 1.25-1.8 1.25-2.6 3.3' +
          'l2.55 1q.5-1.3 1.525-2.125t2.675-.825q1.7 0 2.75.95t1.05 2.4q0 1' +
          '.05-.65 1.975T25.5 22.3q-1.6 1.4-2.3 2.7-.7 1.3-.7 3.3ZM24 43.8q' +
          '-4.1 0-7.7-1.575-3.6-1.575-6.275-4.25Q7.35 35.3 5.775 31.7 4.2 2' +
          '8.1 4.2 24t1.575-7.725q1.575-3.625 4.275-6.3t6.275-4.225Q19.9 4.' +
          '2 23.95 4.2q4.15 0 7.775 1.55t6.3 4.225q2.675 2.675 4.225 6.3Q43' +
          '.8 19.9 43.8 24t-1.55 7.675q-1.55 3.575-4.225 6.275t-6.3 4.275Q2' +
          '8.1 43.8 24 43.8Z"/></svg>'
        FixedColor = xFFFCFBFB
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
          end>
        IconName = 'account_balance_wallet_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M32.6 27.2q1.25 0 2.225-.975.975-.975.975-2.275 0-1.25-.' +
          '975-2.2-.975-.95-2.225-.95t-2.225.95q-.975.95-.975 2.2 0 1.3.975' +
          ' 2.275.975.975 2.225.975ZM9 36.35V39 9 36.35ZM9 42q-1.15 0-2.075' +
          '-.9Q6 40.2 6 39V9q0-1.15.925-2.075Q7.85 6 9 6h30q1.2 0 2.1.925Q4' +
          '2 7.85 42 9v6.7h-3V9H9v30h30v-6.65h3V39q0 1.2-.9 2.1-.9.9-2.1.9Z' +
          'm17.9-8.65q-1.7 0-2.7-1-1-1-1-2.65V18.35q0-1.7 1-2.675 1-.975 2.' +
          '7-.975h13.5q1.7 0 2.7.975 1 .975 1 2.675V29.7q0 1.65-1 2.65t-2.7' +
          ' 1Zm14.2-3V17.7H26.2v12.65Z"/></svg>'
        FixedColor = xFFFBFBFB
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 48
          end>
        IconName = 'sell_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M25.8 44q-.6 0-1.15-.175-.55-.175-1.05-.675L4.85 24.4q-.' +
          '5-.5-.675-1.05Q4 22.8 4 22.2V7q0-1.3.85-2.15Q5.7 4 7 4h15.2q.6 0' +
          ' 1.2.175t1.1.675L43.15 23.5q1 1 1 2.225t-1 2.225l-15.2 15.2q-.4.' +
          '4-.975.625Q26.4 44 25.8 44Zm.1-2.9 15.2-15.2L22.2 7H7v15.2ZM12.2' +
          '5 14.8q1.05 0 1.825-.775.775-.775.775-1.825 0-1.05-.775-1.825Q13' +
          '.3 9.6 12.25 9.6q-1.05 0-1.825.775-.775.775-.775 1.825 0 1.05.77' +
          '5 1.825.775.775 1.825.775ZM7 7Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 20
          end>
        IconName = 'receipt_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M6 43.95V4.05l3 3 3-3 3 3 3-3 3 3 3-3 3 3 3-3 3 3 3-3 3 ' +
          '3 3-3v39.9l-3-3-3 3-3-3-3 3-3-3-3 3-3-3-3 3-3-3-3 3-3-3Zm5.85-10' +
          '.75h24.5v-3h-24.5Zm0-7.7h24.5v-3h-24.5Zm0-7.75h24.5v-3h-24.5ZM9 ' +
          '38.9h30V9.1H9ZM9 9.1v29.8Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 20
          end>
        IconName = 'database_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M24 22q-8.05 0-13.025-2.45T6 14q0-3.15 4.975-5.575Q15.95' +
          ' 6 24 6t13.025 2.425Q42 10.85 42 14q0 3.1-4.975 5.55Q32.05 22 24' +
          ' 22Zm0 10q-7.3 0-12.65-2.2Q6 27.6 6 24.5v-5q0 1.95 1.875 3.375t4' +
          '.65 2.35q2.775.925 5.9 1.35Q21.55 27 24 27q2.5 0 5.6-.425 3.1-.4' +
          '25 5.875-1.325 2.775-.9 4.65-2.325Q42 21.5 42 19.5v5q0 3.1-5.35 ' +
          '5.3Q31.3 32 24 32Zm0 10q-7.3 0-12.65-2.2Q6 37.6 6 34.5v-5q0 1.95' +
          ' 1.875 3.375t4.65 2.35q2.775.925 5.9 1.35Q21.55 37 24 37q2.5 0 5' +
          '.6-.425 3.1-.425 5.875-1.325 2.775-.9 4.65-2.325Q42 31.5 42 29.5' +
          'v5q0 3.1-5.35 5.3Q31.3 42 24 42Z"/></svg>'
        FixedColor = xFFFBFBFB
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 20
          end>
        IconName = 'trending_down_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M32.65 36v-3H39L26.95 20.95 18.6 29.3 4 14.75l2.15-2.15L' +
          '18.55 25l8.35-8.35L41.05 30.8v-6.15H44V36Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 20
          end>
        IconName = 'trending_flat_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="m35.1 32.95-2.15-2.1 5.3-5.3H6v-3h32.3l-5.3-5.3 2.1-2.1 ' +
          '8.9 8.9Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 20
          end>
        IconName = 'trending_up_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M6.15 36 4 33.85 18.6 19.3l8.35 8.35L39 15.6h-6.35v-3H44' +
          'v11.35h-2.95V17.8L26.9 31.95l-8.35-8.35Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
          end>
        IconName = 'monetization_on_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M22.55 38.35h2.75v-2.6q3.05-.35 4.75-1.875 1.7-1.525 1.7' +
          '-4.075 0-2.55-1.45-4.15-1.45-1.6-4.9-3.05-2.9-1.2-4.2-2.15-1.3-.' +
          '95-1.3-2.55 0-1.55 1.125-2.45 1.125-.9 3.075-.9 1.5 0 2.6.7t1.85' +
          ' 2.1l2.4-1.15q-.85-1.75-2.25-2.75t-3.3-1.2V9.7h-2.75v2.55q-2.55.' +
          '35-4.025 1.875Q17.15 15.65 17.15 17.9q0 2.45 1.5 3.9 1.5 1.45 4.' +
          '5 2.7 3.35 1.4 4.6 2.525Q29 28.15 29 29.8q0 1.6-1.325 2.575-1.32' +
          '5.975-3.325.975-1.95 0-3.475-1.1-1.525-1.1-2.125-3l-2.55.85q1.05' +
          ' 2.3 2.575 3.625Q20.3 35.05 22.55 35.65ZM24 44q-4.1 0-7.75-1.575' +
          '-3.65-1.575-6.375-4.3-2.725-2.725-4.3-6.375Q4 28.1 4 24q0-4.15 1' +
          '.575-7.8 1.575-3.65 4.3-6.35 2.725-2.7 6.375-4.275Q19.9 4 24 4q4' +
          '.15 0 7.8 1.575 3.65 1.575 6.35 4.275 2.7 2.7 4.275 6.35Q44 19.8' +
          '5 44 24q0 4.1-1.575 7.75-1.575 3.65-4.275 6.375t-6.35 4.3Q28.15 ' +
          '44 24 44Zm0-3q7.1 0 12.05-4.975Q41 31.05 41 24q0-7.1-4.95-12.05Q' +
          '31.1 7 24 7q-7.05 0-12.025 4.95Q7 16.9 7 24q0 7.05 4.975 12.025Q' +
          '16.95 41 24 41Zm0-17Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 48
          end>
        IconName = 'home_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M8 42V18L24.1 6 40 18v24H28.3V27.75h-8.65V42Zm3-3h5.65V2' +
          '4.75H31.3V39H37V19.5L24.1 9.75 11 19.5Zm13-14.65Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
          end>
        IconName = 'inventory_2_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M6 40.9V16.3q-.7-.1-1.35-1Q4 14.4 4 13.35V7q0-1.15.9-2.0' +
          '75Q5.8 4 7 4h34q1.15 0 2.075.925Q44 5.85 44 7v6.35q0 1.05-.65 1.' +
          '95-.65.9-1.35 1v24.6q0 1.15-.925 2.125Q40.15 44 39 44H9q-1.2 0-2' +
          '.1-.975Q6 42.05 6 40.9Zm3-24.55V41h30V16.35Zm32-3V7H7v6.35Zm-23 ' +
          '13.5h12v-3H18ZM9 41V16.35 41Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 90
          end>
        IconName = 'person_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M24 23.95q-3.3 0-5.4-2.1-2.1-2.1-2.1-5.4 0-3.3 2.1-5.4 2' +
          '.1-2.1 5.4-2.1 3.3 0 5.4 2.1 2.1 2.1 2.1 5.4 0 3.3-2.1 5.4-2.1 2' +
          '.1-5.4 2.1ZM8 40v-4.7q0-1.9.95-3.25T11.4 30q3.35-1.5 6.425-2.25Q' +
          '20.9 27 24 27q3.1 0 6.15.775 3.05.775 6.4 2.225 1.55.7 2.5 2.05.' +
          '95 1.35.95 3.25V40Zm3-3h26v-1.7q0-.8-.475-1.525-.475-.725-1.175-' +
          '1.075-3.2-1.55-5.85-2.125Q26.85 30 24 30t-5.55.575q-2.7.575-5.85' +
          ' 2.125-.7.35-1.15 1.075Q11 34.5 11 35.3Zm13-16.05q1.95 0 3.225-1' +
          '.275Q28.5 18.4 28.5 16.45q0-1.95-1.275-3.225Q25.95 11.95 24 11.9' +
          '5q-1.95 0-3.225 1.275Q19.5 14.5 19.5 16.45q0 1.95 1.275 3.225Q22' +
          '.05 20.95 24 20.95Zm0-4.5ZM24 37Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 16
          end>
        IconName = 'add_shopping_cart_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M23.25 17.35V11.2h-6.2v-3h6.2V2.05h3V8.2h6.15v3h-6.15v6.' +
          '15ZM14.5 44q-1.5 0-2.55-1.05-1.05-1.05-1.05-2.55 0-1.5 1.05-2.55' +
          'Q13 36.8 14.5 36.8q1.5 0 2.55 1.05 1.05 1.05 1.05 2.55 0 1.5-1.0' +
          '5 2.55Q16 44 14.5 44Zm20.2 0q-1.5 0-2.55-1.05-1.05-1.05-1.05-2.5' +
          '5 0-1.5 1.05-2.55 1.05-1.05 2.55-1.05 1.5 0 2.55 1.05 1.05 1.05 ' +
          '1.05 2.55 0 1.5-1.05 2.55Q36.2 44 34.7 44ZM14.5 33.65q-2.1 0-3.0' +
          '75-1.7-.975-1.7.025-3.45l3.05-5.55L7 7H3.1V4h5.8l8.5 18.2H32l7.8' +
          '-14 2.6 1.4-7.65 13.85q-.45.85-1.225 1.3-.775.45-1.825.45h-15l-3' +
          '.1 5.45h24.7v3Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 16
          end>
        IconName = 'remove_shopping_cart_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M32 25.4h-1.75l-2.95-3h4.25l6.3-11.4H15.8l-3-3h26.45q1.3' +
          ' 0 1.9 1.075.6 1.075-.1 2.325L34 24.2q-.3.55-.75.875-.45.325-1.2' +
          '5.325ZM14.35 43.95q-1.5 0-2.55-1.05-1.05-1.05-1.05-2.55 0-1.5 1.' +
          '05-2.55 1.05-1.05 2.55-1.05 1.5 0 2.55 1.05 1.05 1.05 1.05 2.55 ' +
          '0 1.5-1.05 2.55-1.05 1.05-2.55 1.05Zm28.2 2.3-12.8-12.7h-15.9q-1' +
          '.9 0-2.8-1.375-.9-1.375.05-2.975l3.5-5.85L10.3 14l-8-8 2.15-2.15' +
          'L44.7 44.1Zm-15.8-15.7-5.05-5.2h-4.75l-3.15 5.2Zm4.8-8.15H27.3h4' +
          '.25Zm2.85 21.55q-1.45 0-2.525-1.05T30.8 40.35q0-1.5 1.075-2.55 1' +
          '.075-1.05 2.525-1.05t2.525 1.05Q38 38.85 38 40.35q0 1.5-1.075 2.' +
          '55-1.075 1.05-2.525 1.05Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 45
          end>
        IconName = 'menu_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M6 36v-3h36v3Zm0-10.5v-3h36v3ZM6 15v-3h36v3Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 29
          end>
        IconName = 'print_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M32.9 15.6V9H15.1v6.6h-3V6h23.8v9.6ZM7 18.6h34-28.9Zm29.' +
          '95 4.75q.6 0 1.05-.45.45-.45.45-1.05 0-.6-.45-1.05-.45-.45-1.05-' +
          '.45-.6 0-1.05.45-.45.45-.45 1.05 0 .6.45 1.05.45.45 1.05.45ZM32.' +
          '9 39v-9.6H15.1V39Zm3 3H12.1v-8.8H4V20.9q0-2.25 1.525-3.775T9.3 1' +
          '5.6h29.4q2.25 0 3.775 1.525T44 20.9v12.3h-8.1ZM41 30.2v-9.3q0-1-' +
          '.65-1.65-.65-.65-1.65-.65H9.3q-1 0-1.65.65Q7 19.9 7 20.9v9.3h5.1' +
          'v-3.8h23.8v3.8Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 29
          end>
        IconName = 'save_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M9 42q-1.2 0-2.1-.9Q6 40.2 6 39V9q0-1.2.9-2.1Q7.8 6 9 6h' +
          '23.9q.6 0 1.175.25.575.25.975.65l6.05 6.05q.4.4.65.975T42 15.1V3' +
          '9q0 1.2-.9 2.1-.9.9-2.1.9Zm30-26.8L32.8 9H9v30h30ZM24 35.75q2.15' +
          ' 0 3.675-1.525T29.2 30.55q0-2.15-1.525-3.675T24 25.35q-2.15 0-3.' +
          '675 1.525T18.8 30.55q0 2.15 1.525 3.675T24 35.75ZM13.15 18.8h14.' +
          '9q.65 0 1.075-.425.425-.425.425-1.075v-4.15q0-.65-.425-1.075-.42' +
          '5-.425-1.075-.425h-14.9q-.65 0-1.075.425-.425.425-.425 1.075v4.1' +
          '5q0 .65.425 1.075.425.425 1.075.425ZM9 15.2V39 9Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 29
          end>
        IconName = 'delete_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M13.05 42q-1.2 0-2.1-.9-.9-.9-.9-2.1V10.5H8v-3h9.4V6h13.' +
          '2v1.5H40v3h-2.05V39q0 1.2-.9 2.1-.9.9-2.1.9Zm21.9-31.5h-21.9V39h' +
          '21.9Zm-16.6 24.2h3V14.75h-3Zm8.3 0h3V14.75h-3Zm-13.6-24.2V39Z"/>' +
          '</svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 21
          end>
        IconName = 'shopping_cart_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M14.35 43.95q-1.5 0-2.55-1.05-1.05-1.05-1.05-2.55 0-1.5 ' +
          '1.05-2.55 1.05-1.05 2.55-1.05 1.45 0 2.525 1.05t1.075 2.55q0 1.5' +
          '-1.05 2.55-1.05 1.05-2.55 1.05Zm20 0q-1.5 0-2.55-1.05-1.05-1.05-' +
          '1.05-2.55 0-1.5 1.05-2.55 1.05-1.05 2.55-1.05 1.45 0 2.525 1.05t' +
          '1.075 2.55q0 1.5-1.05 2.55-1.05 1.05-2.55 1.05Zm-22.6-33 5.5 11.' +
          '4h14.4l6.25-11.4Zm-1.5-3H39.7q1.6 0 2.025.975.425.975-.275 2.175' +
          'L34.7 23.25q-.5.85-1.4 1.475-.9.625-1.95.625H16.2l-2.8 5.2h24.55' +
          'v3h-24.1q-2.1 0-3.025-1.4-.925-1.4.025-3.15l3.2-5.9L6.45 7h-3.9V' +
          '4H8.4Zm7 14.4h14.4Z"/></svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end
      item
        MultiResBitmap = <
          item
            Size = 65
          end>
        IconName = 'info_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="48" width="48"><' +
          'path d="M24.15 34q.65 0 1.075-.425.425-.425.425-1.075v-9.05q0-.6' +
          '-.45-1.025Q24.75 22 24.15 22q-.65 0-1.075.425-.425.425-.425 1.07' +
          '5v9.05q0 .6.45 1.025.45.425 1.05.425ZM24 18.3q.7 0 1.175-.45.475' +
          '-.45.475-1.15t-.475-1.2Q24.7 15 24 15q-.7 0-1.175.5-.475.5-.475 ' +
          '1.2t.475 1.15q.475.45 1.175.45ZM24 44q-4.25 0-7.9-1.525-3.65-1.5' +
          '25-6.35-4.225-2.7-2.7-4.225-6.35Q4 28.25 4 24q0-4.2 1.525-7.85Q7' +
          '.05 12.5 9.75 9.8q2.7-2.7 6.35-4.25Q19.75 4 24 4q4.2 0 7.85 1.55' +
          'Q35.5 7.1 38.2 9.8q2.7 2.7 4.25 6.35Q44 19.8 44 24q0 4.25-1.55 7' +
          '.9-1.55 3.65-4.25 6.35-2.7 2.7-6.35 4.225Q28.2 44 24 44Zm0-20Zm0' +
          ' 17q7 0 12-5t5-12q0-7-5-12T24 7q-7 0-12 5T7 24q0 7 5 12t12 5Z"/>' +
          '</svg>'
        FixedColor = xFFFDFDFD
        Opacity = 1.000000000000000000
      end>
    Destination = <
      item
        Layers = <
          item
            Name = 'storefront_48px'
            SourceRect.Right = 48.000000000000000000
            SourceRect.Bottom = 48.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'groups_48px'
            SourceRect.Right = 48.000000000000000000
            SourceRect.Bottom = 48.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'finance_48px'
            SourceRect.Right = 32.000000000000000000
            SourceRect.Bottom = 32.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'chart_data_48px'
            SourceRect.Right = 32.000000000000000000
            SourceRect.Bottom = 32.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'help_wght300grad200fill1_48px'
            SourceRect.Right = 48.000000000000000000
            SourceRect.Bottom = 48.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'account_balance_wallet_48px'
            SourceRect.Right = 32.000000000000000000
            SourceRect.Bottom = 32.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'sell_48px'
            SourceRect.Right = 48.000000000000000000
            SourceRect.Bottom = 48.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'receipt_48px'
            SourceRect.Right = 20.000000000000000000
            SourceRect.Bottom = 20.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'database_48px'
            SourceRect.Right = 20.000000000000000000
            SourceRect.Bottom = 20.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'trending_down_48px'
            SourceRect.Right = 20.000000000000000000
            SourceRect.Bottom = 20.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'trending_flat_48px'
            SourceRect.Right = 20.000000000000000000
            SourceRect.Bottom = 20.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'trending_up_48px'
            SourceRect.Right = 20.000000000000000000
            SourceRect.Bottom = 20.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'monetization_on_48px'
            SourceRect.Right = 32.000000000000000000
            SourceRect.Bottom = 32.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'home_48px'
            SourceRect.Right = 48.000000000000000000
            SourceRect.Bottom = 48.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'inventory_2_48px'
            SourceRect.Right = 32.000000000000000000
            SourceRect.Bottom = 32.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'person_48px'
            SourceRect.Right = 90.000000000000000000
            SourceRect.Bottom = 90.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'add_shopping_cart_48px'
          end>
      end
      item
        Layers = <
          item
            Name = 'remove_shopping_cart_48px'
          end>
      end
      item
        Layers = <
          item
            Name = 'menu_48px'
            SourceRect.Right = 45.000000000000000000
            SourceRect.Bottom = 45.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'print_48px'
            SourceRect.Right = 29.000000000000000000
            SourceRect.Bottom = 29.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'save_48px'
            SourceRect.Right = 29.000000000000000000
            SourceRect.Bottom = 29.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'delete_48px'
            SourceRect.Right = 29.000000000000000000
            SourceRect.Bottom = 29.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'shopping_cart_48px'
            SourceRect.Right = 21.000000000000000000
            SourceRect.Bottom = 21.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'info_48px'
            SourceRect.Right = 65.000000000000000000
            SourceRect.Bottom = 65.000000000000000000
          end>
      end
      item
        Layers = <
          item
            Name = 'Item 0'
            SourceRect.Right = 32.000000000000000000
            SourceRect.Bottom = 32.000000000000000000
          end>
      end>
    FixedColor = xFFFDFDFD
    Left = 544
    Top = 224
  end
  object dscQuery: TDataSource
    DataSet = ADOQuery1
    Left = 544
    Top = 456
  end
  object ADOQuery1: TADOQuery
    Connection = conEnviroPosDB
    Parameters = <>
    Left = 544
    Top = 368
  end
end
