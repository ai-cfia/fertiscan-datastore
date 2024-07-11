# FertiScan Datastore

This is the doc about the FertiScan datastore

``` mermaid

---
title: FertiScan DB Structure
---
erDiagram
  user{
    uuid id PK
    string email
    string name
    string last_name
    uuid id_region FK
    timestamp registration_date
    timestamp updated_at
    int permission_id
  }
    object {
    uuid id PK
    uuid user_id FK
    TIMESTAMP upload_date
    TIMESTAMP updated_at
  }
  fertiliser_object{
    uuid id PK
    uuid object_id PK
    uuid fertiliser_id PK
  }
  group{
    uuid id PK
    string name
    int permission_id FK
    uuid owner_id FK
    timestamp upload_date
  }
  permission{
    int id PK
    string name
  }
  user_group{
    uuid id PK
    uuid user_id FK
    uuid group_id FK
    timestamp upload_date
  }
  companie{
    uuid id PK
    string name
    string address
    string website
    string phone_number
  }
    manufacturer{
    uuid id PK
    string name
    string address
    string website
    string phone_number
  }
    manufacturer_companie{
    uuid id PK
    uuid companie_id FK
    uuid manufacturer_id FK
  }
  fertiliser{
    uuid id PK
    string name
    string registration_number
    timestamp upload_date
    timestamp update_time
    uuid fertiliser_information FK
    uuid manufacturer_companie_id FK
  }


  region{
    uuid id PK
    string address
    string city
  }


  information{
    uuid id PK
    string lot_number
    string npk
    text seller_garantie
    uuid precautionary_id FK
    uuid guaranteed_analysis_id FK
    uuid instruction_id FK
    uuid ingredient_id FK
    uuid specification_id FK
    uuid caution_id FK
    uuid recommendation_id FK
    uuid first_aid_id FK
    uuid warranty_id FK
    uuid danger_id FK
    uuid information_metrics_id FK

  }

  precautionary{
    uuid id PK
    text precautionary_fr
    text precautionary_en
  }

  instruction{
    uuid id PK
    text instruction_fr
    text instruction_en
  }

  ingredient{
    uuid id PK

  }

  specification{
    uuid id PK
    text specification_fr
    text specification_en
  }

  caution{
    uuid id PK
    text caution_fr
    text caution_en
  }

  recommendation{
    uuid id PK
    text recommendation_fr
    text recommendation_en
  }

  first_aid{
    uuid id PK
    text first_aid_fr
    text first_aid_en
  }

  warranty{
    uuid id PK
    text warranty_fr
    text warranty_en
  }

  danger{
    uuid id PK
    text danger_fr
    text danger_en
  }

  guaranteed_analysis{
    uuid id PK
    uuid nutrient_id FK
    uuid percentage_id FK
  }

  nutrient{
    uuid id PK
    string name
    char sign
  }

  percentage{
    uuid id PK
    decimal percentage
  }

  information_metrics{
    uuid id PK
    uuid information_id FK
    uuid metrics_id FK
  }

  metrics{
    uuid id PK
    string metric_type
    decimal metric_value
    char unit
  }

    fertiliser_object ||--o{ fertiliser: "fertiliser_id"
    fertiliser_object ||--o{ object: "object_id"
    fertiliser ||--o{ object: "object_type_id"
    fertiliser ||--o{information:"information_id"
    fertiliser ||--o{manufacturer_companie:"id"
    object ||--o{ user: "user_id"
    group ||--o{ permission: "permission_id"
    user_group ||--o{ group: "group_id"
    user_group ||--o{ user: "user_id"
    user ||--o{ region: "id_region"
    manufacturer_companie ||--o{ companie: "companie_id"
    manufacturer_companie ||--o{ manufacturer: "manufacturer_id"
    guaranteed_analysis ||--o{ nutrient: "nutrient_id"
    guaranteed_analysis ||--o{ percentage: "percentage_id"
    information ||--o{caution:"caution_id"
    information ||--o{precautionary:"precautionary_id"
    information ||--o{instruction:"instruction_id"
    information ||--o{ingredient:"ingredient_id"
    information ||--o{danger:"danger_id"
    information ||--o{specification:"specification_id"
    information ||--o{recommendation:"recommendation_id"
    information ||--o{first_aid:"first_aid_id"
    information ||--o{warranty:"warranty_id"
    information ||--o{caution:"caution_id"
    information ||--o{caution:"caution_id"
    information ||--o{guaranteed_analysis:"id"
    information ||--o{information_metrics:"id"
    information_metrics ||--o{metrics:"id"

```
