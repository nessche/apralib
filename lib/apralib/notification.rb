module ApraService

  class Notification

    attr_accessor :purpose, :purpose_description, :expense_amount, :expense_description,
                  :grant_date, :granted_to_group, :amount, :grantee, :work_start_date,
                  :work_end_date, :reference


    def to_hash
      result = {}
      result[:kayttotarkoitus] =purpose
      result[:kayttotarkoitustarkenne] = purpose_description if purpose_description
      result[:kuluosuusrahamaara] = expense_amount
      result[:kuluosuusteksti] = expense_description if expense_description
      result[:myontopaatoksen_antopvm] = grant_date
      result[:onko_myonnetty_tyoryhmalle] = granted_to_group
      result[:rahamaara] = amount
      result[:saajatiedot] = grantee.to_hash
      result[:sisaltaako_kuluja] = (expense_amount > 0)
      result[:tyon_kesto_kuukausia] = 0
      result[:tyon_kesto_paivia] = 0
      result[:tyon_kesto_vuosia] = 0
      result[:tyoskentelyn_alkamispvm] = work_start_date
      result[:tyoskentelyn_paattamispvm] = work_end_date

    end


  end


end